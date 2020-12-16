@testable import CoreMafia
import XCTest

final class StringTests: XCTestCase {
    func testTimeLine() {
        let time = TimeLine()
        XCTAssertEqual(time.description, "Day 1 day")
    }

    func testRole() {
        let role = Role(Game())
        XCTAssertEqual(role.description, "Role")
    }

    func testPlayer() {
        let position = 0
        let role = Role(Game())
        let player = Player(role: role, position: position)
        XCTAssertEqual(player.description, "Player \(position)(\(role))")
    }
}
