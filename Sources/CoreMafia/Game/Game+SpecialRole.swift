//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/13.
//

import Foundation

extension Game {
    var activeSeer: Seer? {
        if let seerIndex = seerIndex, players[seerIndex].isActive {
            return players[seerIndex].role as? Seer
        }
        return nil
    }

    var activeWitch: Witch? {
        if let witchIndex = witchIndex, players[witchIndex].isActive {
            return players[witchIndex].role as? Witch
        }
        return nil
    }

    var activeSavior: Savior? {
        if let saviorIndex = saviorIndex, players[saviorIndex].isActive {
            return players[saviorIndex].role as? Savior
        }
        return nil
    }

    var activeCrow: Crow? {
        if let crowIndex = crowIndex, players[crowIndex].isActive {
            return players[crowIndex].role as? Crow
        }
        return nil
    }

    var activeSecret: FakeVillager? {
        if let secretIndex = secretIndex, players[secretIndex].isActive {
            return players[secretIndex].role as? FakeVillager
        }
        return nil
    }
}
