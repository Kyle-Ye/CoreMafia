//
//  Player.swift
//  mafia-test2
//
//  Created by 叶絮雷 on 2020/11/21.
//

import Foundation

class Player {
    let id = UUID()
    let role: Role
    let position: Int
    private var active = true
    var isDead: Bool { !active }
    var isActive: Bool { active }
    init(role: Role, position: Int) {
        self.role = role
        self.position = position
        self.role.player = self
    }

    // MARK: Votes

    var protected = false
    var lynchVotes = 0
    var killVotes = 0

    func reset() {
        protected = false
        lynchVotes = 0
        killVotes = 0
    }

    var detected = false
    var claimed = false

    /**
         The player get lynched and return the result

         - Returns: Lynch is successful or not
     */
    func getLynched() -> Bool {
        active = false
        return true
    }
    /**
         The player get killed and return the result

         - Returns: Kill event is successful or not
     */
    func getKilled() -> Bool {
        if protected {
            return false
        } else {
            active = false
            return true
        }
    }
}
