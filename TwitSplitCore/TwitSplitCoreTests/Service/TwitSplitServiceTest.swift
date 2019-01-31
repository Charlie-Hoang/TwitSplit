//
//  TwitSplitTest.swift
//  TwitSplitCoreTests
//
//  Created by Charlie on 1/28/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import XCTest
@testable import TwitSplitCore

class TwitSplitTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNormalMessage() {
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]
        let service = TwitSplit()
        let result = service.splitMessage(message: input)
        
        XCTAssertTrue(result.isSuccess, "Result should be success")
        XCTAssertEqual(result.result?.count, 2, "Should return 2 chunks")
        XCTAssertEqual(result.toStringArray(), expected, "Should equal to expected")
    }
    func testMaxLengthMessage(){
        let input = "I can believe 123456789_123456789_123456789_123456789_123456789_1 fradf"
        let service = TwitSplit()
        let result = service.splitMessage(message: input)
        
        XCTAssertFalse(result.isSuccess, "Result should be failed")
    }
    func testLongMessage(){
        let input = "123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 1234 123456789"
        let expected = ["1/20 123456789 123456789 123456789 123456789",
                        "2/20 123456789 123456789 123456789 123456789",
                        "3/20 123456789 123456789 123456789 123456789",
                        "4/20 123456789 123456789 123456789 123456789",
                        "5/20 123456789 123456789 123456789 123456789",
                        "6/20 123456789 123456789 123456789 123456789",
                        "7/20 123456789 123456789 123456789 123456789",
                        "8/20 123456789 123456789 123456789 123456789",
                        "9/20 123456789 123456789 123456789 123456789",
                        "10/20 123456789 123456789 123456789 123456789",
                        "11/20 123456789 123456789 123456789 123456789",
                        "12/20 123456789 123456789 123456789 123456789",
                        "13/20 123456789 123456789 123456789 123456789",
                        "14/20 123456789 123456789 123456789 123456789",
                        "15/20 123456789 123456789 123456789 123456789",
                        "16/20 123456789 123456789 123456789 123456789",
                        "17/20 123456789 123456789 123456789 123456789",
                        "18/20 123456789 123456789 123456789 123456789",
                        "19/20 123456789 123456789 123456789 123456789 1234",
                        "20/20 123456789"]
        
        let service = TwitSplit()
        let result = service.splitMessage(message: input)
        
        XCTAssertTrue(result.isSuccess, "Result should be success")
        XCTAssertEqual(result.result?.count, 20, "Should return 20 chunks")
        XCTAssertEqual(result.toStringArray(), expected, "Should equal to expected")
    }

}
