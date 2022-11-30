//
//  ValidatorTests.swift
//  SeSACIAPLectureTests
//
//  Created by 황은지 on 2022/11/30.
//

import XCTest
@testable import SeSACIAPLecture

final class ValidatorTests: XCTestCase {
    
    var sut: Validator!

    override func setUpWithError() throws {
       sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // 빨리, 고립(다른 테스트에 영향 X), 항상 같은 결과(Repeatable)
    // 네트워크 비동기 테스트?
    func testValidator_validEmail_returnTrue() throws {
        let user = User(email: "lia@lia.com", password: "1234", check: "1234")
        let valid = sut.isValidEmail(email: user.email)
        XCTAssertTrue(valid)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
