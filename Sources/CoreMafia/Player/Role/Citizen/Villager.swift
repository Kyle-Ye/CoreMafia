//
//  Villager.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

class Villager: Role {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int? {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else if let index = game.activeList
            .subtracting(game.whiteList)
            .subtracting([player.position])
            .randomElement() {
            return index
        } else if let index = game.activeList
            .subtracting(game.claimedSpecialList)
            .subtracting([player.position])
            .randomElement() {
            return index
        } else {
            return nil
        }
    }

    // MARK: - Night Event
}

extension Villager: Citizen {}
