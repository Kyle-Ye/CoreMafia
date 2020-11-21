//
//  DayTime.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

class TimeLine {
    enum Time {
        case day, night
    }

    private(set) var time = Time.night
    private(set) var round = 1

    func next() {
        switch time {
        case .day:
            time = .night
        case .night:
            time = .day
            round += 1
        }
    }
}
