//
//  Game.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Combine
import Foundation

public class WerewolfGame {
    // MARK: - Public Init Method

    /**
         Initializes a mafia game with the specific number of characters.

         - Parameters:
             - N: The number of total players
             - m: The number of mafias
             - s: The number of seers
             - d: The number of saviors

         - Returns: A mafia game
     */
//    public convenience init(_ N: Int, _ m: Int, _ s: Int, _ d: Int) {
//        precondition(N >= m + s + d, "The total number of players must great or equal to the mafias and the special citizens")
//        self.init(m: m, s: s, d: d, o: N - m - s - d)
//    }

    // MARK: - Combine SetUp

    var anyCancellable: AnyCancellable?

    @Published private var game = Game()

    // MARK: - Game Play API

    public func autoplay() {
        while !game.gameOver {
            game.play()
        }
    }

    public func play() {
        game.play()
    }

    public func replay() {
        game = Game()
        initGame()
    }

    // MARK: - Game State

    public var time: TimeLine {
        game.time
    }

    public var players: [Player] {
        game.players
    }

    public var logger: LogHistory {
        game.logger
    }

    /**
     0 means no result
     1 means citizen wins
     -1 means werewolf wins
     */
    public var result: Int {
        return game.result
    }

    public var resultString: String {
        if game.result == 1 {
            return "Citizen Group wins"
        } else if game.result == -1 {
            return "Werewolf Group wins"
        } else {
            return "Unknown result"
        }
    }

    // MARK: - Private Property and Method

    private var werewolfNumber = 0
    private var villagerNumber = 0
    private var seerNumber = 0
    private var witchNumber = 0
    private var saviorNumber = 0
    private var hunterNumber = 0
    private var crowNumber = 0
    private var idiotNumber = 0

    public init(werewolf: Int, villager: Int, seer: Int = 1,
                 witch: Int = 0, savior: Int = 0, hunter: Int = 0,
                 crow: Int = 0, idiot: Int = 0) {
        werewolfNumber = werewolf
        villagerNumber = villager
        seerNumber = seer
        witchNumber = witch
        saviorNumber = savior
        hunterNumber = hunter
        crowNumber = crow
        idiotNumber = idiot
        initGame()
    }

    private func initGame() {
        var roles: [Role] = []
        for _ in 0 ..< werewolfNumber {
            roles.append(Werewolf(game))
        }
        for _ in 0 ..< villagerNumber {
            roles.append(Villager(game))
        }
        for _ in 0 ..< seerNumber {
            roles.append(Seer(game))
        }
        for _ in 0 ..< witchNumber {
            roles.append(Witch(game))
        }
        for _ in 0 ..< saviorNumber {
            roles.append(Savior(game))
        }
        for _ in 0 ..< hunterNumber {
            roles.append(Hunter(game))
        }
        for _ in 0 ..< crowNumber {
            roles.append(Crow(game))
        }
        for _ in 0 ..< idiotNumber {
            roles.append(Idiot(game))
        }
        roles.shuffle()
        for role in roles {
            game.addPlayer(with: role)
        }
        anyCancellable = game.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}

extension WerewolfGame: ObservableObject {
}
