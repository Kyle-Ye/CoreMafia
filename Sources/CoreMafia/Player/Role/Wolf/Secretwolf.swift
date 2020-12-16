//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/13.
//

import Foundation

class Secretwolf: Werewolf {
    func mask() -> Role {
        FakeVillager(game, self)
    }
}
