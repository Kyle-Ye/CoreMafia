//
//  GameInfo.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

class Game {
    // MARK: - Timeline and Event

    @Published var logger = LogHistory()
    @Published var time = TimeLine()
    @Published private(set) var result = 0
    var revote = false
    var tiedRevote = false
    var killResult: (index: Int, success: Bool)?
    var lynchResult: (index: Int, success: Bool)?

    func play() {
        if !gameOver {
            time.next()
            logger.next()
            switch time.time {
            case .day:
                dayEvent()
            case .night:
                nightEvent()
            }
        }
        if gameOver {
            if activeCitizenNumber == 0 {
                result = -1
            } else if activeWolfNumber == 0 {
                if let mask = activeSecret {
                    mask.revert()
                } else {
                    result = 1
                }
            }
        }
    }

    // MARK: - Init Game
    var rule:GameRule
    init(rule:GameRule = GameRule()) {
        self.rule = rule
    }
    private(set) var players: [Player] = []
    private(set) var initWolfNumber = 0
    private(set) var initSpecialNumber = 0
    var publiclyLynchedWolfNumber = 0
    var publiclyClaimedSpecialNumber = 0
    
    var seerIndexes: [Int] = []
    var crowIndexes: [Int] = []

    var witchIndex: Int?
    var saviorIndex: Int?
    var secretIndex: Int?

    func addPlayer(with role: Role) {
        switch role {
        case is Seer:
            seerIndexes.append(players.count)
            initSpecialNumber += 1
        case is Witch:
            witchIndex = players.count
            initSpecialNumber += 1
        case is Savior:
            saviorIndex = players.count
            initSpecialNumber += 1
        case is Crow:
            crowIndexes.append(players.count)
            initSpecialNumber += 1
        case is Hunter:
            initSpecialNumber += 1
        case is FakeVillager:
            secretIndex = players.count
        case is Wolf:
            initWolfNumber += 1
        default:
            break
        }
        players.append(Player(role: role, position: players.count))
    }
}

// MARK: - Combine Protocol

extension Game: ObservableObject {}
