//
//  Werewolf.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Werewolf: Role, Wolf {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else {
            let index = game.activeList
                .subtracting(game.whiteList)
                .subtracting(game.wolfList)
                .subtracting([player.position])
                .randomElement()!
            return index
        }
    }

    // MARK: - Night Event

    func killVote() {
        let index = getKillVoteIndex()
        game.playerGetKillVoted(index)
        logger.info("Player \(index) get a kill voted")
    }

    func getKillVoteIndex() -> Int {
        if game.claimedSpecialList.count == 0{
            let index = game.activeList
                .subtracting(game.wolfList)
                .randomElement()!
            return index
        }else{
            let index = game.claimedSpecialKillIndexes.first!
            return index
        }
    }
}
