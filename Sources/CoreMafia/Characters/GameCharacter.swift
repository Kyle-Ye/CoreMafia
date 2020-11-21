//
//  GameCharacter.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/30.
//

import Foundation
import os
let logger = Logger()
class GameCharacter {
    let id = UUID()
    unowned let game: Game
    let type = AIType.strong
    var protected = false
    var votes = 0
    init(_ game: Game) {
        self.game = game
    }

    func getProtected() {
        protected = true
    }

    func getVoted() {
        votes += 1
    }

    // TODO:
    // 1. 优化 比如狼人不投狼人
    // 2. 是否有必要自己不投自己（问老师）
    func vote() {
        if game.currentCharactersNumber == 0 {
            return
        } else {
            let index = Int.random(in: 0 ..< game.currentCharactersNumber)
            game.characterGetVoted(index)
            logger.info("Citizen \(index) get voted")
        }
    }

    func reset() {
        protected = false
        votes = 0
    }
}
