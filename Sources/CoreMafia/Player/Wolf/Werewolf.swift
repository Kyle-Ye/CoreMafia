//
//  Werewolf.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

/**
 可模拟部分狼为强AI，部分狼为弱AI的情况
 */
class Werewolf: Role, Wolf {
    /**
     -   strong
         -   无守卫：有神杀神，无神随机（*神的优先级）
         -   有守卫：有守卫杀守卫，否则随机
     -   weak
         -   有神杀神，无神随机
     */
    func killVote() {
        switch type {
        case .strong:
            if game.saviorIndex != nil {
                if let index = game.saviorIndex {
                    game.playerGetKillVoted(index)
                } else {
                    randomKillVote()
                }
            } else {
                fallthrough
            }
        case .weak:
            if !game.claimedSpecialPlayerIndexes.isEmpty {
                if let index = game.claimedSpecialPlayerIndexes.first {
                    game.playerGetKillVoted(index)
                } else {
                    logger.error("Unknown situation")
                }
            } else {
                randomKillVote()
            }
        }
    }

    private func randomKillVote() {
        if let index = game.activePlayerIndexes.randomElement() {
            game.playerGetKillVoted(index)
            logger.info("Player \(index) get a kill voted")
        }
    }

    private func randomCitizenKillVote() {
    }

    private func knownSpecialKillVote() {
    }
}
