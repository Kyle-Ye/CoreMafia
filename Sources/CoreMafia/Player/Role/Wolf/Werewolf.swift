//
//  Werewolf.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Werewolf: Role, Wolf {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int? {
        let unknownGoodList = game.activeList
            .subtracting(game.whiteList)
            .subtracting(game.wolfList)

        if unknownGoodList.count > 0 {
            if let wolfIndex = game.blackList.first {
                return wolfIndex
            } else {
                return unknownGoodList.first
            }
        } else {
            return getKillVoteIndex()
        }
    }

    // MARK: - Night Event

    func killVote() {
        let index = getKillVoteIndex()
        game.playerGetKillVoted(index, from: player.position)
    }

    func getKillVoteIndex() -> Int {
        if game.claimedSpecialList.count == 0 {
            return getRandomKillVoteIndex()
        } else {
            if game.rule.saviorRule == .otherCanSame {
                if let savior = game.activeSavior, savior.player.claimed{
                    return savior.player.position
                }else if game.claimedSpecialList.count == 1 {
                    return getRandomKillVoteIndex()
                }else{
                    return game.claimedSpecialList.randomElement()!
                }
            } else {
                let index = game.claimedSpecialKillIndexes.first!
                return index
            }
        }
    }
    private func getRandomKillVoteIndex()->Int{
        var list = game.activeList
            .subtracting(game.wolfList)
        if let secret = game.secretIndex {
            list = list.subtracting([secret])
        }
        if let index = list.randomElement() {
            return index
        } else {
            return game.secretIndex!
        }
    }
}
