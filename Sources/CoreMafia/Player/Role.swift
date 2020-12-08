//
//  GameCharacter.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/30.
//

import Foundation

public class Role {
    let type = AIType.strong
    unowned let game: Game
    unowned var player: Player?
    public var rawString:String {
        String(String(describing: self).split(separator: ".")[1])
    }
    init(_ game: Game) {
        self.game = game
    }

    // TODO:
    // 1. 优化 比如狼人不投狼人
    // 2. 是否有必要自己不投自己（问老师）
    func vote() {
        if let wolfIndex = game.detectedWolfIndexes.first{
            game.playerGetLynchVoted(wolfIndex)
            logger.info("Player(Wolf) \(wolfIndex) get voted by Player \(self.player!.position)")
        }else{
            randomVote()
        }
    }

    private func randomVote() {
        if game.activePlayerNumber != 0 {
            let index = game.activePlayerIndexes.randomElement()!
            game.playerGetLynchVoted(index)
            logger.info("Player \(index) get voted by Player \(self.player!.position)")
        }
    }
    var logger:LogHistory{
        game.logger
    }
}
