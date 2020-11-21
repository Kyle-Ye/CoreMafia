import XCTest
@testable import CoreMafia

final class CoreMafiaTests: XCTestCase {
    func testExample() {
        let game = WerewolfGame.init(15, 5, 1, 1)
        game.play()
        print(game.resultString)
        XCTAssertTrue([1,-1].contains(game.result))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
