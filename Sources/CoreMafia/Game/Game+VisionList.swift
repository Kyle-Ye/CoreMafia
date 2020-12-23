//
//  VisionList.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

extension Game {
    // MARK: - Global Vision

    public var whiteList: Set<Int> {
        let claimed = Set(activeIndexes.filter { index -> Bool in
            let player = players[index]
            return player.claimed && player.role is Citizen
        })
        var seer: Set<Int> = []
        for seerIndex in seerIndexes {
            if players[seerIndex].claimed {
                seer.formUnion(seerWhiteList(seerIndex))
            }
        }
        var savior: Set<Int> = []
        if let saviorIndex = saviorIndex, players[saviorIndex].claimed {
            savior = saviorWhiteList
        }
        var witch: Set<Int> = []
        if let witchIndex = witchIndex, players[witchIndex].claimed {
            witch = witchWhiteList
        }
        return claimed.union(seer).union(savior).union(witch)
    }

    public var blackList: Set<Int> {
        var seer: Set<Int> = []
        for seerIndex in seerIndexes {
            if players[seerIndex].claimed {
                seer.formUnion(seerBlackList(seerIndex))
            }
        }
        return seer
    }

    public var unknownList: Set<Int> {
        Set(activeIndexes).subtracting(whiteList).subtracting(blackList)
    }

    public var activeList: Set<Int> {
        Set(activeIndexes)
    }

    public var claimedSpecialList: Set<Int> {
        Set(activeIndexes.filter { index -> Bool in
            if players[index].role is SpecialRole {
                return players[index].claimed
            }
            return false
        })
    }

    // MARK: - Seer's Vision

    public func seerWhiteList(_ seerIndex: Int) -> Set<Int> {
        Set(activeIndexes.filter { index -> Bool in
            let player = players[index]
            return player.detectedSeerList.contains(seerIndex) && player.role is Citizen
        })
    }

    public func seerBlackList(_ seerIndex: Int) -> Set<Int> {
        Set(activeIndexes.filter { index -> Bool in
            let player = players[index]
            return player.detectedSeerList.contains(seerIndex) && player.role is Wolf
        })
    }

    public func undetectedList(_ seerIndex: Int) -> Set<Int> {
        Set(activeIndexes.indices.filter { index -> Bool in
            let player = players[index]
            return !player.detectedSeerList.contains(seerIndex)
        })
    }

    // MARK: - Savior's Vision

    public var saviorWhiteList: Set<Int> {
        Set(activeIndexes.filter { index -> Bool in
            let player = players[index]
            return player.trustedBySavior
        })
    }

    // MARK: - Witch's Vision

    public var witchWhiteList: Set<Int> {
        Set(activeIndexes.filter { index -> Bool in
            let player = players[index]
            return player.trustedByWitch
        })
    }

    // MARK: - Wolf's Vision

    public var wolfList: Set<Int> {
        Set(activeIndexes.filter { index -> Bool in
            let player = players[index]
            return player.role is Wolf
        })
    }
}
