//
//  DayTime.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

public struct TimeLine {
    public enum Time:String {
        case day, night
    }

    public private(set) var time = Time.day
    public private(set) var round = 1

    mutating func next() {
        switch time {
        case .day:
            time = .night
        case .night:
            time = .day
            round += 1
        }
    }
}
