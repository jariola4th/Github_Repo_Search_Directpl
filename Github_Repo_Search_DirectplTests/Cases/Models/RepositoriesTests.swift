//
//  RepositoriesTests.swift
//  Github_Repo_Search_DirectplTests
//
//  Created by Joyce on 9/28/21.
//

@testable import Github_Repo_Search_Directpl
import XCTest

class RepositoriesTests: XCTestCase {
    
    var repositories: Repositories!
    
    override func setUpWithError() throws {
        super.setUp()
        let json = try getJson(fromJSON: "Repositories")
        repositories = Repositories(json: json)
    }
    
    override func tearDownWithError() throws {
        repositories = nil
        super.tearDown()
    }
    
    func testJSONMapping() {
        XCTAssertEqual(repositories.count(), 5)
    }
    
    func testClear() {
        guard let _ = repositories else {
            return
        }
        let testData = repositories
        testData!.clear()
        XCTAssertEqual(repositories.count(), 0)
    }
    
    func testCount() {
        guard let testData = repositories else {
            return
        }
        XCTAssertEqual(testData.count(), 5)
        testData.clear()
        XCTAssertEqual(repositories.count(), 0)
    }
    
    func testItemAtIndex() {
        guard let testData = repositories else {
            return
        }
        XCTAssertEqual(testData.itemAtIndex(0)?.id, 44838949)
        XCTAssertEqual(testData.itemAtIndex(4)?.id, 20822291)
        XCTAssertEqual(testData.itemAtIndex(2)?.id, 130902948)
        testData.clear()
        XCTAssertNil(testData.itemAtIndex(0)?.id)
    }
    
}
