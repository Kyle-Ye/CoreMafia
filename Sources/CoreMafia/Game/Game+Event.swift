//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

extension Game {
    // MARK: - Day Event

    func dayEvent() {
        for player in players {
            if player.isActive {
                player.role.lynchVote()
            }
        }
        lynchEvent()
    }

    func lynchEvent() {
        if let lynchPlayer = players.max(by: { (p1, p2) -> Bool in
            p1.validLynchVotes < p2.validLynchVotes
        }) {
            let lynchIndex = lynchPlayer.position
            logger.info("Player \(lynchIndex) will be lynched")

            if !lynchPlayer.claimed {
                switch lynchPlayer.role {
                case let special as SpecialRole:
                    special.show()
                    revote = true
                    logger.info("Player \(lynchIndex) claims \(special), Revote")
                case is Citizen:
                    if seerWhiteList.contains(lynchIndex) {
                        if let seerIndex = seerIndex, players[seerIndex].isActive {
                            lynchPlayer.claimed = true
                            (players[seerIndex].role as! Seer).show()
                            revote = true
                            logger.info("Seer claims Citizen, Revote")
                        }
                    } else if saviorWhiteList.contains(lynchIndex) {
                        if let saviorIndex = saviorIndex, players[saviorIndex].isActive {
                            lynchPlayer.claimed = true
                            (players[saviorIndex].role as! Savior).show()
                            revote = true
                            logger.info("Savior claims Citizen, Revote")
                        }
                    } else if witchWhiteList.contains(lynchIndex) {
                        if let witchIndex = witchIndex, players[witchIndex].isActive {
                            lynchPlayer.claimed = true
                            (players[witchIndex].role as! Witch).show()
                            revote = true
                            logger.info("Witch claims Citizen, Revote")
                        }
                    }
                default: break
                }
            }

            if !revote {
                let result = players[lynchIndex].getLynched()
                if result {
                    revote = false
                    logger.info("Player \(lynchIndex) is lynched")
                } else {
                    revote = true
                    logger.error("Unknown situation")
                }
            }
        }
    }

    // MARK: - Night Event

    func nightEvent() {
        for player in players {
            if player.isActive {
                let role = player.role
                switch role {
                case let seer as Seer:
                    seer.detect()
                case let savior as Savior:
                    savior.protect()
                case let crow as Crow:
                    crow.curse()
                case let wolf as Wolf:
                    wolf.killVote()
                default:
                    break
                }
            }
        }
        killEvent()
        for player in players {
            if player.isActive {
                let role = player.role
                switch role {
                default:
                    break
                }
            }
        }
    }

    func killEvent() {
        if let killPlayer = players.max(by: { (p1, p2) -> Bool in
            p1.killVotes < p2.killVotes
        }) {
            let killIndex = killPlayer.position
            let result = players[killIndex].getKilled()
            if result {
                logger.info("Player \(killIndex) is killed")
            } else {
                killPlayer.trustedBySavior = true
                logger.info("Peaceful night, no one gets killed")
            }
        }
    }
}
