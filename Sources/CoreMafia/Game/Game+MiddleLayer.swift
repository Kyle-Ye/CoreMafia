//
//  File.swift
//
//
//  Created by 叶絮雷 on 2020/12/8.
//

import Foundation

extension Game {
    func playerGetProtected(_ index: Int?, from sourceIndex: Int) {
        if let index = index {
            players[index].protected = true
            logger.info("\(players[index]) got protected by \(players[sourceIndex])")
        } else {
            logger.info("\(players[sourceIndex]) chose not to protect")
        }
    }

    func playerGetKillVoted(_ index: Int?, from sourceIndex: Int) {
        if let index = index {
            players[index].killVotes += 1
            logger.info("\(players[index]) got a kill vote from \(players[sourceIndex])")
        } else {
            logger.warning("\(players[sourceIndex]) chose not to kill vote")
        }
    }

    func playerGetLynchVoted(_ index: Int?, from sourceIndex: Int) {
        if let index = index {
            players[index].lynchVotes += 1
            logger.info("\(players[index]) got a lynch vote from \(players[sourceIndex])")
        } else {
            logger.info("\(players[sourceIndex]) chose not to lynch vote")
        }
    }

    func playerGetDetected(_ index: Int?, from sourceIndex: Int) {
        if let index = index {
            players[index].detected = true
            logger.info("\(players[index]) got detected by \(players[sourceIndex])")
        } else {
            logger.info("\(players[sourceIndex]) chose not to detect")
        }
    }

    func playerGetCursed(_ index: Int?, from sourceIndex: Int) {
        if let index = index {
            players[index].cursed = true
            logger.info("\(players[index]) got cursed by \(players[sourceIndex])")
        } else {
            logger.info("\(players[sourceIndex]) chose not to curse")
        }
    }

    func playerGetShot(_ index: Int?, from sourceIndex: Int) {
        if let index = index {
            players[index].getShot()
            logger.info("\(players[index]) got shot by \(players[sourceIndex])")
        } else {
            logger.info("\(players[sourceIndex]) chose not to shoot")
        }
    }
}
