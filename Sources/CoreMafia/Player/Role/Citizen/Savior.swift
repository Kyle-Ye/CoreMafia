//
//  Savior.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation
class Savior: Villager {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else {
            let index = game.activeList
                .subtracting(game.whiteList)
                .subtracting(game.saviorWhiteList)
                .subtracting([player.position])
                .randomElement()!
            return index
        }
    }

    // MARK: - Night Event

    func protect() {
        if let index = getProtectIndex() {
            lastProtectedIndex = index
            game.playerGetProtected(index)
            logger.info("Player \(index) get protected")
        } else {
            logger.info("No one get protected")
        }
    }

    private var lastProtectedIndex: Int?

    func getProtectIndex() -> Int? {
        if lastProtectedIndex != player.position {
            return player.position
        } else if game.claimedSpecialList.count == 1 && game.claimedSpecialProtectIndexes.first != player.position {
            let index = game.claimedSpecialProtectIndexes.first!
            return index
        } else if game.claimedSpecialList.count > 1 {
            let index = game.claimedSpecialProtectIndexes.first!
            if index != player.position {
                return index
            } else {
                return game.claimedSpecialProtectIndexes[1]
            }
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

extension Savior: SpecialRole {
    var protectPriority: Int {
        4
    }
    var killPriority: Int{
        5
    }
}
