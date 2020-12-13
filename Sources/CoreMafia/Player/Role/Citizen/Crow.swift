//
//  Crow.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation
class Crow: Villager {
    // MARK: - Night Event

    func curse() {
        let index = getCurseIndex()
        lastCursedIndex = index
        game.playerGetCursed(index, from: player.position)
    }

    private var lastCursedIndex: Int?

    private func getCurseIndex() -> Int? {
        var wolfList = game.wolfList
        if let last = lastCursedIndex {
            wolfList.subtract([last])
        }
        let notGood = game.activeList
            .subtracting(game.whiteList)
            .subtracting([player.position])

        if let index = wolfList.first {
            return index
        } else if let index = notGood.randomElement() {
            return index
        } else {
            return nil
        }
    }
}

extension Crow: SpecialRole {
    var protectPriority: Int {
        1
    }

    var killPriority: Int {
        1
    }
}
