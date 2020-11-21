//
//  God.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

protocol SpecialCharacter {
    // 神牌的优先级
    var priority: Int { get }
    func show()
}
