//
//  Game.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

public class WerewolfGame {
    /**
         Initializes a mafia game with the specific number of characters.

         - Parameters:
             - N: The number of total players
             - m: The number of mafias
             - s: The number of seers
             - d: The number of saviors

         - Returns: A mafia game
     */
    public convenience init(_ N: Int, _ m: Int, _ s: Int, _ d: Int) {
        precondition(N >= m + s + d, "The total number of players must great or equal to the mafias and the special citizens")
        self.init(m: m, s: s, d: d, o: N - m - s - d)
    }

    public func play() {
        game.play()
    }

    /**
     0 means no result
     1 means citizen wins
     -1 means werewolf wins
     */

    public var result: Int {
        game.result
    }

    var resultString: String {
        if game.result == 1 {
            return "Citizen Group wins"
        } else if game.result == -1 {
            return "Werewolf Group wins"
        } else {
            return "Unknown result"
        }
    }

    /**
         Initializes a mafia game with the specific number of characters.

         - Parameters:
             - m: The number of mafias
             - s: The number of seers
             - d: The number of saviors
             - o: The number of ordinary citizens

         - Returns: A mafia game
     */
    private init(m: Int, s: Int, d: Int, o: Int) {
        var roles: [Role] = []
        for _ in 0 ..< m {
            roles.append(Werewolf(game))
        }
        for _ in 0 ..< s {
            roles.append(Seer(game))
        }
        for _ in 0 ..< d {
            roles.append(Savior(game))
        }
        for _ in 0 ..< o {
            roles.append(Villager(game))
        }
        roles.shuffle()
        for role in roles {
            game.addPlayer(with: role)
        }
    }

    private var game = Game()
}
