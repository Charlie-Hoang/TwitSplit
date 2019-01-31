//
//  TwitSplitValidatorTests.swift
//  TwitSplitCoreTests
//
//  Created by Charlie on 1/29/19.
//  Copyright © 2019 CuongHH. All rights reserved.
//

import XCTest
@testable import TwitSplitCore

class TwitSplitValidatorTests: XCTestCase {
    var config = TwitSplitConfiguration()
    var validator: TwitSplitValidator{return TwitSplitValidator(config: config)}
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testEmptyMessage(){
        let message = ""
        let error = validator.validateMessage(message: message)
        
        XCTAssertNotNil(error, "Should be error")
        XCTAssertEqual(error, .empty, "Should be empty error")
    }
    func testMessageNil(){
        let message: String? = nil
        let error = validator.validateMessage(message: message)
        XCTAssertNotNil(error, "Should be error")
        XCTAssertEqual(error, .invalid, "Should be invalid error")
    }
    func testMessageTooLong(){
        let message = "123456789012345678901234567890123456789012345678901"
        let error = validator.validateMessage(message: message)
        XCTAssertNotNil(error, "Should be error")
        XCTAssertEqual(error, .wordTooLong, "Should be WordTooLong error")
    }
    func testNomalMessage(){
        let message = "12345678901234567890123456789012345678901234567890 12345678"
        let error = validator.validateMessage(message: message)
        XCTAssertNil(error, "Error should be nil")
    }

}
