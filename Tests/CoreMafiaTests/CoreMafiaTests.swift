import XCTest
@testable import CoreMafia

final class CoreMafiaTests: XCTestCase {
    func testExample() {
        let game = WerewolfGame.init(werewolf: 15, villager: 5, seer: 1, witch: 1)
        game.autoplay()
        print(game.resultString)
        XCTAssertTrue([1,-1].contains(game.result))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
