//
//  Savior.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation
class Savior: Citizen, SpecialCharacter {
    func show() {
        game.shownSpecials.append(self)
        game.shownSpecials.sort { (s1, s2) -> Bool in
            s1.priority < s2.priority
        }
    }

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
            if game.shownSpecials.isEmpty {
                selfProtect()
            } else {
                if let index = game.shownSeerIndex {
                    game.characterGetProtected(index)
                } else if let index = game.shownSaviorIndex {
                    game.characterGetProtected(index)
                } else {
                    selfProtect()
                }
            }
        case .weak:
            if game.shownSpecials.isEmpty {
                randomProtect()
            } else {
                if let index = game.shownSeerIndex {
                    game.characterGetProtected(index)
                } else if let index = game.shownSaviorIndex {
                    game.characterGetProtected(index)
                } else {
                    randomProtect()
                }
            }
        }
    }

    // MARK: - Private Implementation

    private func randomProtect() {
        var index = Int.random(in: 0 ..< game.currentCharactersNumber)
        while lastProtected == game.getCharacterID(index) {
            index = Int.random(in: 0 ..< game.currentCharactersNumber)
        }
        game.characterGetProtected(index)
        lastProtected = game.getCharacterID(index)
        logger.info("Citizen \(index) get protected")
    }

    private func selfProtect() {
        if lastProtected == id {
            randomProtect()
        } else {
            getProtected()
            lastProtected = id
            logger.info("Savior protect self")
        }
    }

    private var lastProtected: UUID?
}
