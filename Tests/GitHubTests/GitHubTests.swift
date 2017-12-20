import XCTest
@testable import GitHub

class GitHubTests: XCTestCase {

    func testClientToken() {
        XCTAssertEqual(GitHub(token: "foo").client.token, "foo")
    }

    static var allTests = [
        ("testClientToken", testClientToken),
    ]
}
