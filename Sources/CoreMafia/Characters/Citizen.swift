//
//  Citizen.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/9/29.
//

import Foundation

class Citizen: GameCharacter {
    var killVotes = 0
    // 好人被查明后，置真，投票时投到detected玩家重投，如果Seer没跳则跳
    var detected = false

    func getKillVoted() {
        killVotes += 1
    }

    override func reset() {
        super.reset()
        killVotes = 0
    }
}
