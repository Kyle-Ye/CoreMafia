//
//  Seer.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Seer: Villager {
    // MARK: - Day Event

    override func getLynchVoteIndex() -> Int? {
        if let wolfIndex = game.blackList.first {
            return wolfIndex
        } else {
            let index = game.activeList
                .subtracting(game.whiteList)
                .subtracting(game.seerWhiteList)
                .subtracting([player.position])
                .randomElement()
            return index
        }
    }

    // MARK: - Night Event

    func detect() {
        let index = getDetectIndex()
        game.playerGetDetected(index, from: player.position)
    }

    private func getDetectIndex() -> Int? {
        if let index = game.unknownList.randomElement() {
            return index
        } else if let index = game.undetectedList.randomElement() {
            return index
        } else {
            return nil
        }
    }
}

extension Seer: SpecialRole {
    var protectPriority: Int {
        5
    }

    var killPriority: Int {
        4
    }
}
