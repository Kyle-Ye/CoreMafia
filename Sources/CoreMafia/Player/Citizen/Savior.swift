//
//  Savior.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation
class Savior: Villager, SpecialRole {
    var claimed = false
    let priority = 1
    /**
     -   strong
         -   第一轮守护自己
         -   后面有神守神，无神守护自己
     -   weak
         -   第一晚随机守护
         -   后面有神守神，无神随机守护 (交替守护)
     */
    func protect() {
        switch type {
        case .strong:
            if game.claimedSpecialPlayerIndexes.isEmpty {
                selfProtect()
            } else {
                if let index = game.claimedSpecialPlayerIndexes.first {
                    game.playerGetProtected(index)
                    logger.info("Player \(index) get protected")
                } else {
                    selfProtect()
                }
            }
        case .weak:
            if game.claimedSpecialPlayerIndexes.isEmpty {
                randomProtect()
            } else {
                if let index = game.claimedSpecialPlayerIndexes.first {
                    game.playerGetProtected(index)
                    logger.info("Player \(index) get protected")
                } else {
                    randomProtect()
                }
            }
        }
    }

    // MARK: - Private Implementation

    private func randomProtect() {
        var index = game.activePlayerIndexes.randomElement()!
        while lastProtected == game.getPlayerID(index) {
            index = game.activePlayerIndexes.randomElement()!
        }
        game.playerGetProtected(index)
        lastProtected = game.getPlayerID(index)
        logger.info("Player \(index) get protected by Savior \(self.player!.position)")
    }

    private func selfProtect() {
        if lastProtected == player?.id {
            randomProtect()
        } else {
            game.playerGetProtected(player!.position)
            lastProtected = player?.id
            logger.info("Player \(self.player!.position) get protected by Savior \(self.player!.position)(self)")
        }
    }

    private var lastProtected: UUID?
}
