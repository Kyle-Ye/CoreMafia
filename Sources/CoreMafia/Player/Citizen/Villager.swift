//
//  Villager.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

class Villager: Role,Citizen{
    var killVotes = 0
    // 好人被查明后，置真，投票时投到detected玩家重投，如果Seer没跳则跳
    var detected = false

    func getKillVoted() {
        killVotes += 1
    }
}
