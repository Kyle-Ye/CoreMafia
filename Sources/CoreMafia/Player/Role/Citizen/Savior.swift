//
//  Savior.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation
class Savior: Villager {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int? {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else {
            let index = game.activeList
                .subtracting(game.whiteList)
                .subtracting(game.saviorWhiteList)
                .subtracting([player.position])
                .randomElement()
            return index
        }
    }

    // MARK: - Night Event

    func protect() {
        let index = getProtectIndex()
        lastProtectedIndex = index
        game.playerGetProtected(index, from: player.position)
    }

    private var lastProtectedIndex: Int?

    func getProtectIndex() -> Int? {
        if lastProtectedIndex != player.position {
            return player.position
        } else {
            let claimedSpecialList = game.claimedSpecialList.subtracting([player.position])
            if claimedSpecialList.count > 0 {
                let claimedSpecialIndexes = claimedSpecialList.sorted { (index1, index2) -> Bool in
                    let role1 = game.players[index1].role as! SpecialRole
                    let role2 = game.players[index2].role as! SpecialRole
                    return role1.protectPriority < role2.protectPriority
                }
                let index = claimedSpecialIndexes.first
                return index
            } else if let index = game.whiteList
                .union(game.saviorWhiteList)
                .subtracting([player.position])
                .randomElement() {
                return index
            } else if let index = game.activeList
                .subtracting(game.blackList)
                .subtracting([player.position])
                .randomElement() {
                return index
            } else {
                return nil
            }
        }
    }
}

extension Savior: SpecialRole {
    var protectPriority: Int {
        4
    }

    var killPriority: Int {
        5
    }
}
