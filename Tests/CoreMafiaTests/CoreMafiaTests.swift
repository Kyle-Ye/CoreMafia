import XCTest
@testable import CoreMafia

final class CoreMafiaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CoreMafia().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
