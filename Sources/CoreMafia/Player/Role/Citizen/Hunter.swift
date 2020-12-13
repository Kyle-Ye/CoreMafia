//
//  Hunter.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

class Hunter: Villager {
    // MARK: - Death Event

    func shoot() {
        let index = getShootIndex()
        game.playerGetShot(index, from: player.position)
    }

    private func getShootIndex() -> Int? {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else if game.claimedSpecialList.count == 0 {
            let index = game.activeList
                .subtracting(game.whiteList)
                .randomElement()
            return index
        } else {
            return nil
        }
    }
}

extension Hunter: SpecialRole {
    var protectPriority: Int {
        2
    }

    var killPriority: Int {
        2
    }
}
