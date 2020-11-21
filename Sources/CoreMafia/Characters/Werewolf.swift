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
class Werewolf: GameCharacter {
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
            if game.remainMaxSavior == 0 {
                if game.shownSpecials.isEmpty {
                    randomKillVote()
                } else {
                    if let index = game.shownSeerIndex {
                        game.citizenGetKillVoted(index)
                    } else if let index = game.shownSaviorIndex {
                        game.citizenGetKillVoted(index)
                    } else {
                        logger.error("Unknown situation")
                    }
                }
            } else {
                if let index = game.shownSaviorIndex {
                    game.citizenGetKillVoted(index)
                } else {
                    randomKillVote()
                }
            }
        case .weak:
            if game.shownSpecials.isEmpty {
                randomKillVote()
            } else {
                if let index = game.shownSeerIndex {
                    game.citizenGetKillVoted(index)
                } else if let index = game.shownSaviorIndex {
                    game.citizenGetKillVoted(index)
                } else {
                    logger.error("Unknown situation")
                }
            }
        }
    }

    private func randomKillVote() {
        if game.currentCitizensNumber == 0 {
            return
        } else {
            let index = Int.random(in: 0 ..< game.currentCitizensNumber)
            game.citizenGetKillVoted(index)
            logger.info("Citizen \(index) get killVoted")
        }
    }
}
