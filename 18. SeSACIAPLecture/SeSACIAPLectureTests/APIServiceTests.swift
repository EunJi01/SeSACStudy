//
//  APIServiceTests.swift
//  SeSACIAPLectureTests
//
//  Created by 황은지 on 2022/12/01.
//

import XCTest
@testable import SeSACIAPLecture

final class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        sut = APIService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        print("testExample")
        
        sut.number = 100
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            print("callRequest")
            // 그냥 이렇게 비동기 코드를 넣어버리면 completionHandler는 실행되지 않음
        }
        print("testExample End")
    }
    
    // 비동기: expectation, fulfill, wait
    /*
     네트워크: 아이폰 네트워크 응답X, API 서버 점검, API 지연 등의 환경일 때...?
     효율적/속도/같은 조건에서 테스트 해야 하는데 조건이 깨지게 됨
     테스트 대상이 외부 격리X -> 예측 불가능한 상황을 만들면 안돼!
     => 실제 네트워크 동작이 되는 것 처럼 보이게 별개의 객체를 만듦
     => 테스트 더블(Test Double): 테스트 코드랑 상호작용 할 수 있는 가짜 객체 생성(ex. 스턴트맨)
        ex. dummy, mock, fake, stub, spy...
     */
    func test_APILottoResponse_AsyncCover() throws {
        print("testExample")
        
        let promise = expectation(description: "waiting lotto number, completion handler invoked")
        
        sut.number = 100
        sut.callRequest { value in
            XCTAssertLessThanOrEqual(value, 45)
            XCTAssertGreaterThanOrEqual(value, 1)
            print("callRequest")
            promise.fulfill() // expectation으로 정의된 테스트 조건을 충족!
        }
        print("testExample End")
        
        wait(for: [promise], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
