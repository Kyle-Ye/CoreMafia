//
//  God.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

protocol SpecialRole {
    var protectPriority: Int { get }
    var killPriority: Int { get }
    func show()
}

extension SpecialRole where Self: Role {
    func show() {
        if let player = player {
            if !player.claimed {
                game.logger.info("\(player) claimed to be \(self)")
                player.claimed = true
                game.publiclyClaimedSpecialNumber += 1
            }
        }
    }
}
