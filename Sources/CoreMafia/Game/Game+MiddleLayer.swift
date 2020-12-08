//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

extension Game {
    func playerGetProtected(_ index: Int) {
        players[index].protected = true
    }

    func playerGetKillVoted(_ index: Int) {
        players[index].killVotes += 1
    }

    func playerGetLynchVoted(_ index: Int) {
        players[index].lynchVotes += 1
    }

    func getPlayerID(_ index: Int) -> UUID {
        players[index].id
    }

    func playerGetDetected(_ index: Int) {
        players[index].detected = true
    }
}
