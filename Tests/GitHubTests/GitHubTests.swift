import XCTest
@testable import GitHub

class GitHubTests: XCTestCase {

    func testClientToken() {
        XCTAssertEqual(GitHub(token: "foo").client.token, "foo")
    }

    func testLatestRelease() throws {
        guard let token = ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"] else {
            XCTFail("No token")
            return
        }
        let release = try GitHub(token: token).latestRelease(owner: "eneko", project: "GitHubTest")
        XCTAssertEqual(release, "0.0.0")
    }

    func testPullRequests() throws {
        guard let token = ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"] else {
            XCTFail("No token")
            return
        }
        let pullRequests = try GitHub(token: token).openPullRequests(owner: "eneko", project: "GitHubTest")
        XCTAssertEqual(pullRequests.first?.title, "Update README.md")
    }

    static var allTests = [
        ("testClientToken", testClientToken),
        ("testLatestRelease", testLatestRelease)
    ]
}
