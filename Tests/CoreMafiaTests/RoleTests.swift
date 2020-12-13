@testable import CoreMafia
import XCTest

final class RuleTests: XCTestCase {
    func testAllRoles() {
        let game = WerewolfGame(werewolf: 7, villager: 3, seer: 1, witch: 1,
                                savior: 1, hunter: 1, crow: 1, idiot: 1,
                                secretwolf: 1)
        testRoleHelper(game)
    }

    func testVillager() {
        let game = WerewolfGame(werewolf: 2, villager: 3)
        testRoleHelper(game)
    }

    func testSeer() {
        let game = WerewolfGame(werewolf: 2, villager: 3, seer: 1)
        testRoleHelper(game)
    }

    func testSavior() {
        let game = WerewolfGame(werewolf: 2, villager: 3, seer: 1, witch: 1, savior: 1)
        testRoleHelper(game)
    }

    func testWitch() {
        let game = WerewolfGame(werewolf: 2, villager: 3, witch: 1)
        testRoleHelper(game)
    }

    func testHunter() {
        let game = WerewolfGame(werewolf: 2, villager: 3, hunter: 1)
        testRoleHelper(game)
    }

    func testCrow() {
        let game = WerewolfGame(werewolf: 2, villager: 3, crow: 1)
        testRoleHelper(game)
    }

    func testIdiot() {
        let game = WerewolfGame(werewolf: 2, villager: 3, idiot: 1)
        testRoleHelper(game)
    }
    
    func testSecretwolf(){
        let game = WerewolfGame(werewolf: 1, villager: 3, secretwolf: 1)
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
