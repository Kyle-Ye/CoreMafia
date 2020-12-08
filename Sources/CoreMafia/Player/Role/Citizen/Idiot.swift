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
        if !lynched{
            super.lynchVote()
        }else{
            logger.info("Player \(index) is a lynched idiot, can't lynchVote")
        }
    }
}
