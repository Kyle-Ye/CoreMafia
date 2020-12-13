//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

extension Game {
    private func resetState() {
        for player in players {
            player.reset()
        }
        revote = false
    }

    // MARK: - Day Event

    func dayEvent() {
        if let killResult = killResult, !killResult.success {
            logger.info("Last night was a peaceful night, no one got killed")
            let killPlayer = players[killResult.index]
            if let witch = witch, witch.help {
                witch.show()
                killPlayer.trustedByWitch = true
            } else {
                killPlayer.trustedBySavior = true
            }
        }

        repeat {
            resetState()
            for player in players {
                if player.isActive {
                    player.role.lynchVote()
                }
            }
            lynchEvent()
        } while revote
    }

    // MARK: - Night Event

    func nightEvent() {
        savior?.protect()
        crow?.curse()
        repeat {
            resetState()
            for wolfIndex in wolfList {
                let wolf = players[wolfIndex].role as! Werewolf
                wolf.killVote()
            }
            killEvent()
        } while revote
        seer?.detect()
        witch?.poisonEvent()
    }

    // MARK: - LynchEvent

    func lynchEvent() {
        var lynchIndex: Int?
        var maxVotes = 0
        var equalVotes = false
        for index in activeIndexes {
            let p = players[index]
            if p.lynchVotes > maxVotes {
                lynchIndex = index
                maxVotes = p.lynchVotes
                equalVotes = false
            } else if p.lynchVotes == maxVotes {
                lynchIndex = nil
                equalVotes = true
            }
        }
        if equalVotes {
            tiedRevote.toggle()
            revote = tiedRevote
        } else if let lynchIndex = lynchIndex {
            tiedRevote = false
            WillLynchEvent(lynchIndex)
            if !revote {
                DidLynchEvent(lynchIndex)
            }
        }
    }

    private func WillLynchEvent(_ lynchIndex: Int) {
        logger.info("\(players[lynchIndex]) will be lynched")
        let lynchPlayer = players[lynchIndex]
        if !lynchPlayer.claimed {
            switch lynchPlayer.role {
            case let special as SpecialRole:
                special.show()
                revote = true
                logger.info("\(players[lynchIndex]) claims \(special), Revote")
            case is Citizen:
                if seerWhiteList.contains(lynchIndex) {
                    if let seerIndex = seerIndex, players[seerIndex].isActive {
                        lynchPlayer.claimed = true
                        (players[seerIndex].role as! Seer).show()
                        revote = true
                        logger.info("Seer claims \(players[lynchIndex]), Revote")
                    }
                } else if saviorWhiteList.contains(lynchIndex) {
                    if let saviorIndex = saviorIndex, players[saviorIndex].isActive {
                        lynchPlayer.claimed = true
                        (players[saviorIndex].role as! Savior).show()
                        revote = true
                        logger.info("Savior claims \(players[lynchIndex]), Revote")
                    }
                } else if witchWhiteList.contains(lynchIndex) {
                    if let witchIndex = witchIndex, players[witchIndex].isActive {
                        lynchPlayer.claimed = true
                        (players[witchIndex].role as! Witch).show()
                        revote = true
                        logger.info("Witch claims \(players[lynchIndex]), Revote")
                    }
                }
            default: break
            }
        }
    }

    private func DidLynchEvent(_ lynchIndex: Int) {
        let success = players[lynchIndex].getLynched()
        if success {
            revote = false
            logger.info("\(players[lynchIndex]) is lynched")
        } else {
            revote = true
            logger.error("Unknown situation")
        }
        lynchResult = (lynchIndex, success)
    }

    // MARK: - Kill Event

    private func killEvent() {
        var killIndex: Int?
        var maxVotes = 0
        var equalVotes = false
        for index in activeIndexes {
            let p = players[index]
            if p.killVotes > maxVotes {
                killIndex = index
                maxVotes = p.killVotes
                equalVotes = false
            } else if p.killVotes == maxVotes {
                killIndex = nil
                equalVotes = true
            }
        }

        if equalVotes {
            revote = true
        } else if let killIndex = killIndex {
            willKillEvent(killIndex)
            DidKillEvent(killIndex)
        }
    }

    private func willKillEvent(_ killIndex: Int) {
        logger.info("\(players[killIndex]) will be killed")
        if let witchIndex = witchIndex, players[witchIndex].isActive {
            let witch = players[witchIndex].role as! Witch
            witch.antidoteEvent(killIndex: killIndex)
        }
    }

    private func DidKillEvent(_ killIndex: Int) {
        let success = players[killIndex].getKilled()
        if success {
            logger.info("\(players[killIndex]) is killed")
        }
        killResult = (killIndex, success)
    }
}
