//
//  Player.swift
//  mafia-test2
//
//  Created by 叶絮雷 on 2020/11/21.
//

import Foundation

public class Player {
    // TODO: - remove id?
    public let id = UUID()
    public let role: Role
    public let position: Int
    private var active = true
    public var isDead: Bool { !active }
    public var isActive: Bool { active }
    init(role: Role, position: Int) {
        self.role = role
        self.position = position
        self.role.player = self
    }

    // MARK: Votes

    @Published public var protected = false
    @Published public var lynchVotes = 0
    @Published public var killVotes = 0

    func reset() {
        protected = false
        lynchVotes = 0
        killVotes = 0
    }

    // MARK: State (White&Black List)

    var detected = false
    var claimed = false
    var trustedBySavior = false
    var trustedByWitch = false

    /**
         The player get lynched and return the result

         - Returns: Lynch is successful or not
     */
    func getLynched() -> Bool {
        switch role {
        case let idiot as Idiot:
            idiot.lynched = true
            return false
        default:
            active = false
            return true
        }
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

public extension Player {
    static var testPlayer = Player(role: Seer(Game()), position: 0)
}

extension Player: Identifiable {}
extension Player: ObservableObject {}
