//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/13.
//

import Foundation

class Secretwolf: Werewolf {
    override init(_ game: Game) {
        super.init(game)
    }

    func mask() -> Role {
        FakeVillager(game, self)
    }
}
