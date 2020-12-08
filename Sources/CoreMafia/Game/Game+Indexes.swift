//
//  File.swift
//  
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

extension Game{
    var activeIndexes: [Int] {
        players.indices.filter { index -> Bool in
            players[index].isActive
        }
    }

    var claimedSpecialProtectIndexes: [Int] {
        claimedSpecialList.sorted { (index1, index2) -> Bool in
            let role1 = players[index1].role as! SpecialRole
            let role2 = players[index2].role as! SpecialRole
            return role1.protectPriority < role2.protectPriority
        }
    }
    var claimedSpecialKillIndexes: [Int] {
        claimedSpecialList.sorted { (index1, index2) -> Bool in
            let role1 = players[index1].role as! SpecialRole
            let role2 = players[index2].role as! SpecialRole
            return role1.killPriority < role2.killPriority
        }
    }
}
