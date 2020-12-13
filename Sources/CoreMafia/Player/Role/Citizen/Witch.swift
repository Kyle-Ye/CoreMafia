//
//  Witch.swift
//  mafia-test2
//
//  Created by 叶絮雷 on 2020/11/21.
//

import Foundation

class Witch: Villager {
    private var antidote = 1
    private var poison = 1

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

    // TODO:
}

extension Witch: SpecialRole {
    var protectPriority: Int {
        3
    }

    var killPriority: Int {
        3
    }
}
