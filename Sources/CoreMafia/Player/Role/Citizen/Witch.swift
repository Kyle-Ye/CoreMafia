//
//  Witch.swift
//  mafia-test2
//
//  Created by 叶絮雷 on 2020/11/21.
//

import Foundation

class Witch: Villager {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int? {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else {
            let index = game.activeList
                .subtracting(game.whiteList)
                .subtracting(game.witchWhiteList)
                .subtracting([player.position])
                .randomElement()
            return index
        }
    }

    // MARK: - Night Event

    private static let MAX_CONCOCT_NUMBER = 1 // Max concoct number per night
    private(set) var antidote = 1
    private var poison = 1
    private var concoctedNumber = 0
    var help = false

    func antidoteEvent(killIndex: Int) {
        if antidote > 1 && concoctedNumber < Witch.MAX_CONCOCT_NUMBER {
            let antidoteIndex = getAntidoteIndex(killIndex: killIndex)
            game.playerGetAntidoted(antidoteIndex, from: player.position)
            if antidoteIndex != nil {
                antidote -= 1
                concoctedNumber += 1
                help = true
            }
        }
    }

    func poisonEvent() {
        if poison > 1 && concoctedNumber < Witch.MAX_CONCOCT_NUMBER {
            let poisonIndex = getPoisonIndex()
            game.playerGetPoisoned(poisonIndex, from: player.position)
            if poisonIndex != nil {
                poison -= 1
                concoctedNumber += 1
            }
        }
        concoctedNumber = 0
    }

    private func getAntidoteIndex(killIndex: Int) -> Int? {
        let position = player.position
        if game.time.round == 1 {
            if killIndex == position {
                return killIndex
            } else {
                return nil
            }
        } else {
            return killIndex
        }
    }

    private func getPoisonIndex() -> Int? {
        let list = game.activeList
            .subtracting(game.whiteList)
            .subtracting(game.witchWhiteList)
        if Double(game.activeWolfNumber) / Double(list.count) >= 0.6 {
            if let wolfIndex = game.blackList.randomElement() {
                return wolfIndex
            }
            if let index = list.randomElement() {
                return index
            }
        }
        return nil
    }
}

extension Witch: SpecialRole {
    var protectPriority: Int {
        3
    }

    var killPriority: Int {
        3
    }
}
