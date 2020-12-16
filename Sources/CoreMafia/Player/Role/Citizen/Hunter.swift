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
        } else if game.initSpecialNumber == game.publiclyClaimedSpecialNumber + (player.claimed ? 0 : 1) {
            let list = game.activeList
                .subtracting(game.claimedSpecialList)
            if let index = list
                .subtracting(game.whiteList)
                .randomElement() {
                return index
            } else if let index = list
                .randomElement() {
                return index
            } else {
                return nil
            }
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
