//: [Previous](@previous)

import UIKit

/*
 MARK: Meta type: 클래스, 구조체, 열거형 유형 그 자체를 가리킴 (타입의 타입)
 String 타입은 String.Type
 */

struct User {
    let name = "고래밥" // 인스턴스 프로퍼티
    static let originalName = "jack" // 타입 프로퍼티
}

let user = User() // 인스턴스로 name 호출 0, originalName 호출X
user.name
user.self.name

User.originalName
User.self.originalName

type(of: user.name) // "고래밥" - String Value, user.name String 타입의 인스턴스, String은 String.Type
type(of: User.self)
type(of: user)

let intValue: Int = 9.self // Int 타입은 사실 구조체 Int 인스턴스
let intType: Int.Type = Int.self // Meta Type




/*
 MARK: try!
 Swift Error Handling: try, do try catch
 */

// 들어온 값이 숫자이면 true, 그게 아니면 false
func validateUserInput(text: String) -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        print("빈값")
        return false
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return true
    }
    return true
}

if validateUserInput(text: "20200101") { // 활용 예) 영진원 박스오피스
    print("검색 가능")
} else {
    print("검색 불가능")
}

enum ValidationError: Int, Error {
    case emptyString = 500
    case isNotInt = 400
    case isNotDate = 401
    case collLimit
    case serverError
}

func validateUserInputError(text: String) throws -> Bool {
    // 입력한 값이 비었는지
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    // 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        throw ValidationError.isNotInt
    }
    return true
}

do {
    try validateUserInputError(text: "20200202")
    print("성공!")
} catch ValidationError.emptyString {
    print("empty")
} catch ValidationError.isNotInt {
    print("is not int")
} catch {
    print("Error...")
}



//: [Next](@next)
