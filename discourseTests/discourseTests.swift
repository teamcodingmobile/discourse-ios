//
//  discourseTests.swift
//  discourseTests
//
//  Created by Gerardo Rico Botella on 31/10/2020.
//

import XCTest
import Resolver
@testable import discourse

class discourseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLatestTopics() throws {
        let expectation = XCTestExpectation(description: "Get latest topics")
        
        let client = Resolver.resolve(DataClient.self)
        
        client.getLatestTopics(atPage: 1) { (latestTopics) in
            XCTAssertNotNil(latestTopics)
            XCTAssertTrue((latestTopics as Any) is [TopicItem])
            expectation.fulfill()
        } onError: { (error) in
            XCTFail("Request failed")
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
