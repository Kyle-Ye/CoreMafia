//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/13.
//

import Foundation

extension Game {
    var activeSeers: [Seer] {
        var seers:[Seer] = []
        for seerIndex in seerIndexes{
            if players[seerIndex].isActive,let seer = players[seerIndex].role as? Seer{
                seers.append(seer)
            }
        }
        return seers
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

    var activeCrows: [Crow] {
        var crows:[Crow] = []
        for crowIndex in crowIndexes{
            if players[crowIndex].isActive,let crow = players[crowIndex].role as? Crow{
                crows.append(crow)
            }
        }
        return crows
    }

    var activeSecret: FakeVillager? {
        if let secretIndex = secretIndex, players[secretIndex].isActive {
            return players[secretIndex].role as? FakeVillager
        }
        return nil
    }
}
