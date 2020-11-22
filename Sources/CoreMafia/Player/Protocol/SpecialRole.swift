//
//  God.swift
//  mafia-test
//
//  Created by 叶絮雷 on 2020/10/3.
//

import Foundation

protocol SpecialRole {
    var priority: Int { get }
    func show()
}

extension SpecialRole where Self: Role {
    func show() {
        player!.claimed = true
        player!.detected = true
    }
}
