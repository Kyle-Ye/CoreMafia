@testable import CoreMafia
import XCTest

final class RuleTests: XCTestCase {
    func testAllRoles() {
        let game = WerewolfGame(werewolf: 7, villager: 3, withSeer: true,
                                withWitch: true, withSavior: true, withHunter: true,
                                withCrow: true, withIdiot: true, withSecretwolf: true)
        testRoleHelper(game)
    }

    func testVillager() {
        let game = WerewolfGame(werewolf: 2, villager: 3)
        testRoleHelper(game)
    }

    func testSeer() {
        let game = WerewolfGame(werewolf: 2, villager: 3, withSeer: true)
        testRoleHelper(game)
    }

    func testSavior() {
        let game = WerewolfGame(werewolf: 2, villager: 3, withSeer: true,
                                withWitch: true, withSavior: true)
        testRoleHelper(game)
    }

    func testWitch() {
        let game = WerewolfGame(werewolf: 2, villager: 3, withWitch: true)
        testRoleHelper(game)
    }

    func testHunter() {
        let game = WerewolfGame(werewolf: 2, villager: 3, withHunter: true)
        testRoleHelper(game)
    }

    func testCrow() {
        let game = WerewolfGame(werewolf: 2, villager: 3, withCrow: true)
        testRoleHelper(game)
    }

    func testIdiot() {
        let game = WerewolfGame(werewolf: 2, villager: 3, withIdiot: true)
        testRoleHelper(game)
    }

    func testSecretwolf() {
        let game = WerewolfGame(werewolf: 1, villager: 3, withSecretwolf: true)
        testRoleHelper(game)
    }

    private func testRoleHelper(_ game: WerewolfGame) {
        for _ in 0 ..< 1000 {
            game.autoplay()
            XCTAssertTrue(game.result != 0)
            game.replay()
        }
    }
}
