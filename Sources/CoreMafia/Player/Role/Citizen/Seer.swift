//
//  Seer.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Seer: Villager {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else {
            let index = game.activeList
                .subtracting(game.whiteList)
                .subtracting(game.seerWhiteList)
                .subtracting([player.position])
                .randomElement()!
            return index
        }
    }

    // MARK: - Night Event

    func detect() {
        if let index = game.unknownList.randomElement() {
            game.playerGetDetected(index)
            logger.info("Player \(index) get detected")
        } else if let index = game.undetectedList.randomElement() {
            game.playerGetDetected(index)
            logger.info("Player \(index) get detected")
        } else {
            logger.info("No one get detected")
        }
    }
}

extension Seer: SpecialRole {
    var protectPriority: Int {
        5
    }
    var killPriority: Int{
        4
    }
}
