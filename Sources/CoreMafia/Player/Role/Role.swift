//
//  GameCharacter.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/30.
//

import Foundation

// MARK: - Role

public class Role {
    let type = AIType.strong
    unowned let game: Game
    unowned var player: Player!

    init(_ game: Game) {
        self.game = game
    }

    func lynchVote() {
        let index = getLynchVoteIndex()
        game.playerGetLynchVoted(index, from: player.position)
    }

    func getLynchVoteIndex() -> Int? {
        getRandomLynchVoteOthersIndex()
    }
}

// MARK: - Role String

extension Role: CustomStringConvertible {
    public var description: String {
        String(describing: Swift.type(of: self))
    }
}

// MARK: - Helper Function

extension Role {
    private func getRandomLynchVoteIndex() -> Int? {
        game.activeIndexes.randomElement()
    }

    private func getRandomLynchVoteOthersIndex() -> Int? {
        let index = game.activeList
            .subtracting([player.position])
            .randomElement()
        return index
    }
}
