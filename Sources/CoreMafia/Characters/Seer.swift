//
//  Seer.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Seer: Citizen, SpecialCharacter {
    func show() {
        game.shownSpecials.append(self)
        game.shownSpecials.sort { (s1, s2) -> Bool in
            s1.priority < s2.priority
        }
    }

    let priority = 2

    func detect() {
        let index = Int.random(in: 0 ..< game.currentCharactersNumber)
        game.characterGetDetected(index)
        logger.info("Character \(index) get detected")
    }
}
