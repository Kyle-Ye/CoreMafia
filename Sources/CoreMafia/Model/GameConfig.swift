//
//  GameConfig.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import Foundation

public class GameConfig: ObservableObject {
    @Published public var werewolf: Int = 2
    @Published public var villager: Int = 5
    @Published public var seer: Int = 0
    @Published public var hunter: Int = 0
    @Published public var crow: Int = 0
    @Published public var idiot: Int = 0
    @Published public var withWitch: Bool = false
    @Published public var withSavior: Bool = false
    @Published public var withSecretwolf: Bool = false
    public init() {
    }
}

extension GameConfig {
    public var witch: Int {
        withWitch ? 1 : 0
    }

    public var savior: Int {
        withSavior ? 1 : 0
    }

    public var secretwolf: Int {
        withSecretwolf ? 1 : 0
    }
}

extension WerewolfGame {
    public convenience init(config: GameConfig, rule: GameRule = GameRule()) {
        self.init(werewolf: config.werewolf, villager: config.villager, seer: config.seer,
                  hunter: config.hunter, crow: config.crow, idiot: config.idiot,
                  withWitch: config.withWitch, withSavior: config.withSavior, withSecretwolf: config.withSecretwolf,
                  rule: rule)
    }
}
