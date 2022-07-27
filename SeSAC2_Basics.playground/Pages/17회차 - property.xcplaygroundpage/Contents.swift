//: [Previous](@previous)

import UIKit

// 인스턴스 생성 여부와 상관없이 타입 프로퍼티의 값은 하나다!

struct User {
    static var originalName = "진짜이름" // 타입 저장 프로퍼티
    var nickname = "고래밥" // 인스턴스 저장 프로퍼티
}

var user1 = User()
user1.nickname = "올라프"
User.originalName = "리JACK"
print(user1.nickname, User.originalName)

var user2 = User()
print(user2.nickname, User.originalName)

var user3 = User()
print(user3.nickname, User.originalName)

var user4 = User()
print(user4.nickname, User.originalName)

/*
 연산 프로퍼티(인스턴스 연산 프로퍼티 / 타입 연산 프로퍼티)
 */

struct BMI {
    var nickname: String {
        willSet(newNickname) {
            print("유저 닉네임이 \(nickname)에서 \(newNickname)로 변경될 예정이에여")
        }
        didSet {
            print("유저 닉네임 변경 완료!!! \(oldValue) -> \(nickname)으로 바뀜!")
        }
    }
    var weight: Double
    var height: Double
    
    // 연산 프로퍼티
    // 저장 프로퍼티는 메모리 O, 연산 프로퍼티는 저장 프로퍼티를 활용해서 원하는 값을 반환하는 용도로 주로 사용!
    // 읽기 전용(read-only) 프로퍼티이지만 계산하는 값에 따라 결과가 달라질 수 있기 때문!
    var BMIResult: String {
        get {
            let bmiValue = (weight * weight) / height
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            return "\(nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"
        }
        set {
            nickname = newValue
        }
    }
    
    var sample: String {
        return "\(Int.random(in: 1...100))"
    }
}

var bmi = BMI(nickname: "고래밥", weight: 50, height: 180)

//let bmiValue = (bmi.weight * bmi.weight) / bmi.height
//let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
//let reuslt = "\(bmi.nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"

let result = bmi.BMIResult // get
print(result)

bmi.BMIResult = "올라프" // set
print(bmi.BMIResult)

class FoodRestaurant {
    let name = "잭치킨"
    var totalOrderCount = 10 // 총 주문건수
    
    var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set { // set은 옵션
            totalOrderCount += newValue // 기본 파라미터 newValue, 변경 가능!
        }
    }
}

let food = FoodRestaurant()

print(food.nowOrder)

//food.totalOrderCount += 5
//food.totalOrderCount += 20
//food.totalOrderCount += 100

food.nowOrder = 5
food.nowOrder = 20
food.nowOrder = 100
// 연산 프로퍼티의 nowOrder에 값을 넘겨 최종적으로 totalOrderCount를 업데이트한다

print(food.nowOrder)
// 그리고 위에서 set으로 업데이트한 값을 이용하여 get으로 최종 결과를 반환


// 열거형은 타입 자체 => 인스턴스 생성 불가능 => 초기화 구문 X
// 인스턴스 생성을 통해서 접근할 수 있는 인스턴스 저장 프로퍼티 사용 불가! 인스턴스 연산 프로퍼티는?
// 메모리의 관점 + 열거형이 컴파일 타임에 확정되어야 한다! => 인스턴스 연산 프로퍼티는 열거형에서 사용할 수 있다...
// 타입 저장 프로퍼티 => 열거형에서 사용 가능!
enum ViewType {
    case start
    case chang
    
    // var nickname: String = 고래밥
    
    var nickname: String {
        return "aa"
    }
    
    static var title = "시작하기"
}

// 타입 저장 프로퍼티는 인스턴스랑 상관없이 접근 가능! 따라서 열거형에서 타입 저장 프로퍼티, 타입 연산 프로퍼티는 모두 사용 가능!
// 인스턴스 저장 프로퍼티는 메모리, 값이 달라질 수 있음 => X => 열거형은 초기화 구문을 만들 수 없기 때문이다.

// 타입 저장 프로퍼티, 타입 연산 프로퍼티, 인스턴스 저장 프로퍼티, 인스턴스 연산 프로퍼티

ViewType.title
ViewType.start.nickname

class TypeFoodRestaurant {
    static let name = "잭치킨" // 타입 상수 저장 프로퍼티
    static var totalOrderCount = 10 {
        willSet { // 변경되기 직전에 실행
            print("총 주문 건수가 \(totalOrderCount)에서 \(newValue)로 변경될 예정입니다.")
        }
        didSet { // 변경 되고난 직후에 실행
            print("총 주문 건수가 \(oldValue)에서 \(totalOrderCount)로 변경되었습니다.")
        }
    }
    
    static var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        set { // set은 옵션
            totalOrderCount += newValue // 기본 파라미터 newValue, 변경 가능!
        }
    }
}

TypeFoodRestaurant.nowOrder // 타입 연산 프로퍼티 Get

TypeFoodRestaurant.nowOrder = 15 // 타입 연산 프로퍼티 Set

TypeFoodRestaurant.nowOrder

// Property Observer : 저장 프로퍼티에서 주로 사용되고, 저장 프로퍼티 값을 관찰을 하다가 변경이 될 것 같을 때 또는 변경이 되었을 때 호출됨! (willSet / didSet)


// 메서드 : 타입 메서드 & 인스턴스 메서드
struct Coffee {
    static var name = "아메리카노"
    static var shot = 2
    var price = 4900
    
    mutating func plusShot() {
//        shot += 1
        price += 300
        // 구조체 내에서 프로퍼티를 변경하려고 하면 mutating 키워드를 붙여야 한다.
    }
    
    static func minusShot() {
        shot -= 1
    }
}

//class Latte: Coffee {
//
//    override class func minusShot() { // 슈퍼클래스의 타입 메서드를 재정의해서 쓰고싶다면 static 대신 class 사용!
//        <#code#>
//    }
//
//}

//: [Next](@next)
