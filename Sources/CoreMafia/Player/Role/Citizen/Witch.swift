//
//  Witch.swift
//  mafia-test2
//
//  Created by 叶絮雷 on 2020/11/21.
//

import Foundation

class Witch: Villager {
    
}

extension Witch: SpecialRole {
    var protectPriority: Int {
        3
    }
    var killPriority: Int{
        3
    }
}
