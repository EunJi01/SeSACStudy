//
//  SeSACIAPLectureTests.swift
//  SeSACIAPLectureTests
//
//  Created by 황은지 on 2022/11/29.
//

import XCTest
@testable import SeSACIAPLecture
// MARK: target이 다르니까 import로 가져와서 사용할 수 있음! + public 대신 @testable 사용

final class SeSACIAPLectureTests: XCTestCase {
    
    var sut: LoginViewController! // system under test: 테스트를 하고자 하는 클래스를 정의할 때 사용하는 변수명!

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        sut.loadViewIfNeeded() // 스토리보드 및 @IBOutlet 사용 시 필요!
    }

    override func tearDownWithError() throws {
        sut = nil // 초기화시켜서 독립적인 실행을 갖게 해야 함
    }

    // 이메일 유효성 테스트
    // TDD - Arrange, Act, Assert
    // BDD - Given, When, Then
    func testLoginViewController_validEmail_returnTrue() throws {
        // 테스트 객체: Given, Arrange
        sut.emailTextField.text = "lia@lia.com"
        
        // 테스트 조건/행동: When, Act
        let valid = sut.isValidEmail()
        
        // 테스트 결과: Then, Assert
        XCTAssertTrue(valid) // true일 경우 테스트 성공
    }
    
    func testLoginViewController_validPassword_ReturnFalse() throws {
        sut.passwordTextField.text = "1234"
        let valid = sut.isValidPassword()
        XCTAssertFalse(valid) // false일 경우 테스트 성공!
    }
    
    func testLoginViewController_emailTextField_ReturnNil() throws {
        sut.emailTextField = nil
        let value = sut.emailTextField
        XCTAssertNil(value)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
