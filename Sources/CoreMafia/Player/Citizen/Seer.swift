//
//  Seer.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Seer: Villager, SpecialRole {
    var claimed = false
    let priority = 3

    func detect() {
        var index = game.activePlayerIndexes.randomElement()!
        while index == game.seerIndex!{
            index = game.activePlayerIndexes.randomElement()!
        }
        game.playerGetDetected(index)
        logger.info("Player \(index) get detected")
    }
}
