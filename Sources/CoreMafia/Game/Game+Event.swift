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
            logger.info("Last night was a peaceful night, no one got killed\n")
            let killPlayer = players[killResult.index]
            if let witch = activeWitch, witch.help {
                witch.show()
                killPlayer.trustedByWitch = true
                witch.help = false
            } else {
                killPlayer.trustedBySavior = true
            }
        }
        logger.info("\(time) began\n")
        repeat {
            resetState()
            for player in players {
                if player.isActive {
                    player.role.lynchVote()
                }
            }
            lynchEvent()
            if revote{
                logger.info("Revote!\n")
            }
        } while revote
        logger.info("\n\(time) ended")
    }

    // MARK: - Night Event

    func nightEvent() {
        logger.info("\(time) began\n")
        activeSavior?.protect()
        activeCrow?.curse()
        repeat {
            resetState()
            for wolfIndex in wolfList {
                let wolf = players[wolfIndex].role as! Werewolf
                wolf.killVote()
            }
            killEvent()
            if revote{
                logger.info("Revote!\n")
            }
        } while revote
        activeSeer?.detect()
        activeWitch?.poisonEvent()
        logger.info("\n\(time) ended")
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
            logger.info("Tied lynch votes occurred")
            tiedRevote.toggle()
            revote = tiedRevote
        } else if let lynchIndex = lynchIndex {
            logger.info("\(players[lynchIndex]) got \(maxVotes) lynchVotes(max)")
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
            case is Citizen:
                if seerWhiteList.contains(lynchIndex) {
                    if let seer = activeSeer {
                        seer.show()
                        revote = true
                        logger.info("\(seer.player!) claimed \(players[lynchIndex]) to be citizen")
                    }
                } else if saviorWhiteList.contains(lynchIndex) {
                    if let savior = activeSavior {
                        savior.show()
                        revote = true
                        logger.info("\(savior.player!) claimed \(players[lynchIndex]) to be citizen")
                    }
                } else if witchWhiteList.contains(lynchIndex) {
                    if let witch = activeWitch {
                        witch.show()
                        revote = true
                        logger.info("\(witch.player!) claimed \(players[lynchIndex]) to be citizen")
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
            logger.info("\(players[lynchIndex]) was lynched")
            if blackList.contains(lynchIndex){
                publiclyLynchedWolfNumber += 1
            }else if seerBlackList.contains(lynchIndex){
                if let seer = activeSeer{
                    seer.seerPubliclyLynchedWolfNumber += 1
                }
            }
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
            logger.info("Tied kill votes occurred")
            revote = true
        } else if let killIndex = killIndex {
            willKillEvent(killIndex)
            DidKillEvent(killIndex)
        }
    }

    private func willKillEvent(_ killIndex: Int) {
        logger.info("\(players[killIndex]) will be killed")
        if let witch = activeWitch {
            witch.antidoteEvent(killIndex: killIndex)
        }
    }

    private func DidKillEvent(_ killIndex: Int) {
        let success = players[killIndex].getKilled()
        if success {
            logger.info("\(players[killIndex]) was killed")
        }
        killResult = (killIndex, success)
    }
}
