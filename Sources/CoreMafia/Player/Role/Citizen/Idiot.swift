//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

class Idiot: Villager {
    var lynched: Bool = false

    override func lynchVote() {
        if !lynched {
            super.lynchVote()
        } else {
            game.logger.info("\(player!) is a lynched idiot, can't lynch vote")
        }
    }
}
