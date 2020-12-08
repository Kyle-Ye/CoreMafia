//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

// MARK: - Count API

extension Game {
    var activeNumber: Int {
        activeIndexes.count
    }

    var activeCitizenNumber: Int {
        activeIndexes.filter { i -> Bool in
            players[i].role is Citizen
        }.count
    }

    var activeWolfNumber: Int {
        activeIndexes.filter { i -> Bool in
            players[i].role is Wolf
        }.count
    }

    var gameOver: Bool {
        (activeNumber == 0) || (activeWolfNumber == 0)
    }
}
