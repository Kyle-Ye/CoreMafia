//
//  Hunter.swift
//  
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

class Hunter: Villager {
}

extension Hunter: SpecialRole {
    var protectPriority: Int {
        2
    }
    var killPriority: Int{
        2
    }
}
