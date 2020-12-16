//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/13.
//

import Foundation

class FakeVillager: Villager {
    var original: Secretwolf
    init(_ game: Game, _ original: Secretwolf) {
        self.original = original
        super.init(game)
    }

    func revert() {
        original.player = player
        player.role = original
        game.logger.info("\(player!) got reverted from \(self)")
        player = nil
    }
}
