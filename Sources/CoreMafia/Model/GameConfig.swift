//
//  GameConfig.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import Foundation

public class GameConfig: ObservableObject {
    @Published public var werewolf: Int = 5
    @Published public var villager: Int = 0
    @Published public var withSeer: Bool = false
    @Published public var withWitch: Bool = false
    @Published public var withSavior: Bool = false
    @Published public var withHunter: Bool = false
    @Published public var withCrow: Bool = false
    @Published public var withIdiot: Bool = false
    @Published public var withSecretwolf: Bool = false
    @Published public var round: Int = 1000
    public init() {
    }
}

extension GameConfig {
    public var seer: Int {
        withSeer ? 1 : 0
    }

    public var witch: Int {
        withWitch ? 1 : 0
    }

    public var savior: Int {
        withSavior ? 1 : 0
    }

    public var hunter: Int {
        withHunter ? 1 : 0
    }

    public var crow: Int {
        withCrow ? 1 : 0
    }

    public var idiot: Int {
        withIdiot ? 1 : 0
    }

    public var secretwolf: Int {
        withSecretwolf ? 1 : 0
    }
}

extension WerewolfGame {
    public convenience init(config: GameConfig) {
        self.init(werewolf: config.werewolf, villager: config.villager, withSeer: config.withSeer,
                  withWitch: config.withWitch, withSavior: config.withSavior, withHunter: config.withHunter,
                  withCrow: config.withCrow, withIdiot: config.withIdiot, withSecretwolf: config.withSecretwolf)
    }
}
