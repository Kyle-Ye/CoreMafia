//
//  GameInfo.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

class Game {
    // MARK: - Init

    private var characters: [GameCharacter] = []
    private var citizens: [Citizen] = []
    private var seer: Seer?
    private func addCharacter(_ character: GameCharacter) {
        characters.append(character)
    }

    func addSeer() {
        let seer = Seer(self)
        citizens.append(seer)
        addCharacter(seer)
        self.seer = seer
    }

    func addSavior() {
        let savior = Savior(self)
        citizens.append(savior)
        addCharacter(savior)
        remainMaxSavior += 1
    }

    func addVillager() {
        let villager = Villager(self)
        citizens.append(villager)
        addCharacter(villager)
    }

    func addWerewolf() {
        addCharacter(Werewolf(self))
    }

    // MARK: - Count API

    var currentCharactersNumber: Int {
        characters.count
    }

    var currentCitizensNumber: Int {
        citizens.count
    }

    var currentWerewolvesNumber: Int {
        currentCharactersNumber - currentCitizensNumber
    }

    // MARK: - Timeline and Event

    let time = TimeLine()
    private var revote = false

    func play() {
        while !gameOver {
            nightEvent()
            time.next()

            if gameOver {
                break
            }

            repeat {
                dayEvent()
            } while revote
            time.next()
        }
        if currentCitizensNumber == 0 {
            result = -1
        } else if currentWerewolvesNumber == 0 {
            result = 1
        }
    }

    private(set) var result = 0
    private var gameOver: Bool {
        (currentCitizensNumber == 0) || (currentWerewolvesNumber == 0)
    }

    private func dayEvent() {
        for character in characters {
            character.vote()
        }
        lynchEvent()
    }

    /**
     - Seer detects a character
     - Every savior protects a character
     - Wolves kills a citizen
     */
    private func nightEvent() {
        for character in characters {
            if let seer = character as? Seer {
                seer.detect()
            }
            if let savior = character as? Savior {
                savior.protect()
            }
            if let werewolf = character as? Werewolf {
                werewolf.killVote()
            }
        }
        killEvent()
    }

    private func lynchEvent() {
        var lynchIndex = characters.isEmpty ? -1 : 0
        for index in characters.indices {
            let current = characters[index]
            let lynch = characters[lynchIndex]
            if current.votes > lynch.votes {
                lynchIndex = index
            }
        }
        if lynchIndex != -1 {
            logger.info("Character \(lynchIndex) will be lynched")
            switch characters[lynchIndex] {
            case is Seer:
                (characters[lynchIndex] as! Seer).show()
                revote = true
                logger.info("Seer claims Seer, Revote.")
            case is Savior:
                (characters[lynchIndex] as! Savior).show()
                revote = true
                logger.info("Savior claims Savior, Revote.")
            case is Villager:
                if (characters[lynchIndex] as! Villager).detected {
                    if !(shownSpecials.first?.priority ?? 0 == 2) {
                        seer?.show()
                    }
                    revote = true
                    logger.info("Seer claims Villager, Revote.")
                } else {
                    citizens.remove(at: lynchIndex)
                    characters.remove(at: lynchIndex)
                    revote = false
                    logger.info("Citizen \(lynchIndex) is lynched")
                }
            case is Werewolf:
                characters.remove(at: lynchIndex)
                revote = false
                logger.info("Werewolf \(lynchIndex - self.currentCitizensNumber) is lynched")
            default:
                logger.error("Unknown situation")
            }
        }
        resetState()
    }

    private func killEvent() {
        var killIndex = citizens.isEmpty ? -1 : 0
        for index in citizens.indices {
            let current = citizens[index]
            let kill = citizens[killIndex]
            if current.killVotes > kill.killVotes {
                killIndex = index
            }
        }
        if killIndex != -1 && !citizens[killIndex].protected {
            if citizens[killIndex] is Seer {
                seer = nil
            }
            if citizens[killIndex] is Savior && shownSaviorIndex != nil {
                remainMaxSavior -= 1
            }
            citizens.remove(at: killIndex)
            characters.remove(at: killIndex)
            logger.info("Citizen \(killIndex) get killed")
        }
        resetState()
    }

    private func resetState() {
        for character in characters {
            character.reset()
        }
    }

    // MARK: - Middle layer

    func characterGetProtected(_ index: Int) {
        characters[index].getProtected()
    }

    func citizenGetKillVoted(_ index: Int) {
        citizens[index].getKillVoted()
    }

    func characterGetVoted(_ index: Int) {
        characters[index].getVoted()
    }

    func getCharacterID(_ index: Int) -> UUID {
        characters[index].id
    }

    var voteWolfIndex: Int?

    func characterGetDetected(_ index: Int) {
        let character = characters[index]
        switch character {
        case is Citizen:
            (character as! Citizen).detected = true
        case is Werewolf:
            voteWolfIndex = index - currentCitizensNumber
        default:
            logger.error("Unknown situation")
        }
    }

    // MARK: - SC API

    var shownSpecials: [SpecialCharacter] = []
    var shownSeerIndex: Int?
    var shownSaviorIndex: Int?
    /**
     开局有多少个守卫初值即为几，只有当跳出来的守卫被狼杀才减1
     */
    var remainMaxSavior = 0
}
