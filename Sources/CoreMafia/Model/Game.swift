//
//  GameInfo.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

class Game {
    @Published var logger = LogHistory()
    
    // MARK: - Init

    private(set) var players: [Player] = []
    var seerIndex: Int?
    var witchIndex: Int?
    var saviorIndex: Int?
    var activePlayerIndexes: [Int] {
        players.indices.filter { index -> Bool in
            players[index].isActive
        }
    }

    var claimedSpecialPlayerIndexes: [Int] {
        players.indices.filter { index -> Bool in
            if players[index].role is SpecialRole {
                return players[index].claimed
            }
            return false
        }.sorted { (index1, index2) -> Bool in
            let role1 = players[index1].role as! SpecialRole
            let role2 = players[index2].role as! SpecialRole
            return role1.priority < role2.priority
        }
    }

    // FIXME: Bug about seerIndex
    var detectedWolfIndexes: [Int] {
        // If this game has a seer
        if let seerIndex = seerIndex {
            return players.indices.filter { index -> Bool in
                let s = players[seerIndex]
                let p = players[index]
                // only when seer is (active and claimed) or dead will wolf be exposed
                return (p.isActive && p.detected && p is Wolf) && ((s.isActive && s.claimed) || s.isDead)
            }
        }
        return []
    }

    var detectedCitizenIndexes: [Int] {
        // If this game has a seer
        if seerIndex != nil {
            return players.indices.filter { index -> Bool in
                let p = players[index]
                return p.isActive && p.detected && p is Citizen
            }
        }
        return []
    }

    func addPlayer(with role: Role) {
        switch role {
        case is Seer:
            seerIndex = players.count
        case is Witch:
            witchIndex = players.count
        default:
            break
        }
        players.append(Player(role: role, position: players.count))
    }

    // MARK: - Count API

    var activePlayerNumber: Int {
        activePlayerIndexes.count
    }

    var activeCitizenNumber: Int {
        activePlayerIndexes.filter { i -> Bool in
            players[i].role is Citizen
        }.count
    }

    var activeWolfNumber: Int {
        activePlayerIndexes.filter { i -> Bool in
            players[i].role is Werewolf
        }.count
    }

    // MARK: - Timeline and Event

    @Published var time = TimeLine()
    private var revote = false

    func play() {
        if !gameOver {
            time.next()
            logger.next()
            switch time.time {
            case .day:
                repeat {
                    resetState()
                    dayEvent()
                } while revote
            case .night:
                resetState()
                nightEvent()
            }
        }
        if gameOver {
            if activePlayerNumber == 0 {
                result = -1
            } else if activeWolfNumber == 0 {
                result = 1
            }
        }
    }

    @Published private(set) var result = 0
    var gameOver: Bool {
        (activePlayerNumber == 0) || (activeWolfNumber == 0)
    }

    private func dayEvent() {
        for player in players {
            if player.isActive {
                player.role.vote()
            }
        }
        lynchEvent()
    }

    /**
     - Seer detects a character
     - Every savior protects a character
     - Wolves kills a citizen
     */
    private func nightEvent() {
        for player in players {
            if player.isActive {
                let role = player.role
                switch role {
                case let seer as Seer:
                    seer.detect()
                case let savior as Savior:
                    savior.protect()
                case let werewolf as Werewolf:
                    werewolf.killVote()
                default:
                    break
                }
            }
        }
        killEvent()
    }

    private func lynchEvent() {
        if let lynchedPlayer = players.max(by: { (p1, p2) -> Bool in
            p1.lynchVotes < p2.lynchVotes
        }) {
            let lynchIndex = lynchedPlayer.position
            logger.info("Player \(lynchIndex) will be lynched")
            if lynchedPlayer.claimed {
                let result = players[lynchIndex].getLynched()
                if result {
                    revote = false
                    logger.info("Player \(lynchIndex) is lynched")
                } else {
                    revote = true
                    logger.info("Unknown situation")
                }
            } else {
                switch players[lynchIndex].role {
                case let seer as Seer:
                    seer.show()
                    revote = true
                    logger.info("Player \(lynchIndex) claims Seer, Revote.")
                case let witch as Witch:
                    witch.show()
                    revote = true
                    logger.info("Player \(lynchIndex) claims Witch, Revote.")
                case let savior as Savior:
                    savior.show()
                    revote = true
                    logger.info("Player \(lynchIndex) claims Savior, Revote.")
                case is Citizen:
                    if let seerIndex = seerIndex, detectedCitizenIndexes.contains(lynchIndex) {
                        lynchedPlayer.claimed = true
                        (players[seerIndex].role as! Seer).show()
                        revote = true
                        logger.info("Seer claims Citizen, Revote.")
                    } else {
                        fallthrough
                    }
                case is Wolf:
                    let result = players[lynchIndex].getLynched()
                    if result {
                        revote = false
                        logger.info("Player \(lynchIndex) is lynched")
                    } else {
                        revote = true
                        logger.info("Unknown situation")
                    }
                default:
                    logger.error("Unknown situation")
                }
            }
        }
    }

    private func killEvent() {
        if let killedPlayer = players.max(by: { (p1, p2) -> Bool in
            p1.killVotes < p2.killVotes
        }) {
            let killIndex = killedPlayer.position
            let result = players[killIndex].getKilled()
            if result {
//                if killedPlayer is Savior {
//                    remainMaxSavior -= 1
//                }
                logger.info("Player \(killIndex) is killed")
            } else {
                logger.info("Peaceful night, no one gets killed")
            }
        }
    }

    private func resetState() {
        for player in players {
            player.reset()
        }
    }

    // MARK: - Middle layer

    func playerGetProtected(_ index: Int) {
        players[index].protected = true
    }

    func playerGetKillVoted(_ index: Int) {
        players[index].killVotes += 1
    }

    func playerGetLynchVoted(_ index: Int) {
        players[index].lynchVotes += 1
    }

    func getPlayerID(_ index: Int) -> UUID {
        players[index].id
    }

    func playerGetDetected(_ index: Int) {
        players[index].detected = true
    }

    // MARK: - SC API

    /**
     开局有多少个守卫初值即为几，只有当跳出来的守卫被狼杀才减1
     */
    var remainMaxSavior = 0
}

extension Game:ObservableObject{}
