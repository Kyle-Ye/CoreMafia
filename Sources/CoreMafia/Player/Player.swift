//
//  Player.swift
//  mafia-test2
//
//  Created by 叶絮雷 on 2020/11/21.
//

import Foundation

public class Player {
    public let id = UUID()
    public var role: Role
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
    @Published public var curseVotes = 0
    @Published public var antidoted = false
    @Published public var lynchVotes = 0
    @Published public var killVotes = 0

    func reset() {
        protected = false
        lynchVotes = 0
        killVotes = 0
        if role.game.time.time == .night {
            curseVotes = 0
        }
    }

    // MARK: State

    @Published public var detectedSeerList = [Int]()
    @Published public var claimed = false
    @Published public var trustedBySavior = false
    @Published public var trustedByWitch = false

    func getLynched() -> Bool {
        switch role {
        case let idiot as Idiot:
            idiot.lynched = true
            claimed = true
        case let hunter as Hunter:
            active = false
            hunter.shoot()
        default:
            active = false
        }
        return true
    }

    func getKilled() -> Bool {
        if protected {
            return false
        } else {
            active = false
            switch role {
            case let hunter as Hunter:
                hunter.shoot()
            default:
                break
            }
            return true
        }
    }

    func getShot() {
        active = false
    }

    func getAntidoted() {
        protected = true
    }

    func getPoisoned() {
        active = false
    }
}

public extension Player {
    static var testPlayer = Player(role: Seer(Game()), position: 0)
}

extension Player: Identifiable {}
extension Player: ObservableObject {}

extension Player {
    var validLynchVotes: Int {
        lynchVotes + curseVotes
    }
}

extension Player: CustomStringConvertible {
    public var description: String {
        "Player \(position)(\(role))"
    }
}
