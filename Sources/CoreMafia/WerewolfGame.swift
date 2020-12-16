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
             - werewolf: The number of werewolves
             - villager: The number of villagers
         - Returns: A mafia game
     */
    public convenience init(werewolf: Int, villager: Int, withSeer: Bool = false,
                            withWitch: Bool = false, withSavior: Bool = false, withHunter: Bool = false,
                            withCrow: Bool = false, withIdiot: Bool = false, withSecretwolf: Bool = false) {
        self.init(werewolf: werewolf, villager: villager, seer: withSeer ? 1 : 0,
                  witch: withWitch ? 1 : 0, savior: withSavior ? 1 : 0, hunter: withHunter ? 1 : 0,
                  crow: withCrow ? 1 : 0, idiot: withIdiot ? 1 : 0, secretwolf: withSecretwolf ? 1 : 0)
    }

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
    private var secretwolfNumber = 0

    private init(werewolf: Int, villager: Int, seer: Int = 1,
                 witch: Int = 0, savior: Int = 0, hunter: Int = 0,
                 crow: Int = 0, idiot: Int = 0, secretwolf: Int = 0) {
        werewolfNumber = werewolf
        villagerNumber = villager
        seerNumber = seer
        witchNumber = witch
        saviorNumber = savior
        hunterNumber = hunter
        crowNumber = crow
        idiotNumber = idiot
        secretwolfNumber = secretwolf
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
        for _ in 0 ..< secretwolfNumber {
            roles.append(Secretwolf(game))
        }
        roles.shuffle()
        for role in roles {
            if let secret = role as? Secretwolf {
                game.addPlayer(with: secret.mask())
            } else {
                game.addPlayer(with: role)
            }
        }
        anyCancellable = game.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

    // MARK: - Combine SetUp

    private var anyCancellable: AnyCancellable?

    @Published private var game = Game()
}

extension WerewolfGame: ObservableObject {
}
