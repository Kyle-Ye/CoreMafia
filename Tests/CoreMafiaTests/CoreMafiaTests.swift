@testable import CoreMafia
import XCTest

final class CoreMafiaTests: XCTestCase {
    func testExample() {
        let game = WerewolfGame(werewolf: 6, villager: 5, seer: 1,
                                witch: 1, savior: 1, hunter: 1, crow: 1, idiot: 1)
        game.autoplay()
        print(game.resultString)
        XCTAssertTrue([1, -1].contains(game.result))
    }

    func testSuccess() {
        let game = WerewolfGame(werewolf: 2, villager: 10, seer: 1)
        game.autoplay()
        print(game.resultString)
        XCTAssertTrue(game.result == 1)
    }

    func testFail() {
        let game = WerewolfGame(werewolf: 20, villager: 2)
        game.autoplay()
        print(game.resultString)
        XCTAssertTrue(game.result == -1)
    }

    func testNormal() {
        testNormalHelper(wolf: 2, citizen: 3)
        testNormalHelper(wolf: 4, citizen: 6)
    }

    private func testNormalHelper(wolf: Int, citizen: Int,_ round:Int = 1000) {
        var wins = 0
        let game = WerewolfGame(werewolf: wolf, villager: citizen)
        
        for _ in 1 ... round {
            game.autoplay()
            if game.result == 1 {
                wins += 1
            }
            game.replay()
        }

        let rate = Double(wins) / Double(round)
        print(rate)
        XCTAssertTrue((0.35 ... 0.65).contains(rate))
    }

    static var allTests = [
        ("testExample", testExample),
        ("testSuccess", testSuccess),
        ("testFail", testFail),
        ("testNormal", testNormal),
        ("testPerformanceExample", testPerformanceExample),
    ]

    func testPerformanceExample() {
        measure {
            testNormalHelper(wolf: 3, citizen: 6,2000)
        }
    }
}
