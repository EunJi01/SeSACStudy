//: [Previous](@previous)

import UIKit
import Darwin

/*
 MARK: TypeCasting
 - 형변환 => 타입캐스팅/타입변환
 - 타입캐스팅 : 인스턴스의 타입을 확인하거나 인스턴스 자신의 타입을 다른 타입의 인스턴스인 것처럼 사용할 때 활용되는 개념
 */

let a = 3
let value = String(a) // 이니셜라이저 구문을 통해 새롭게 인스턴스를 생성한 것 = 형변환

type(of: a)
type(of: value)

// 애플 구글 모바일
class Mobile {
    let name: String
    var introduce: String {
        return "\(name)입니다"
    }
    init(name: String) {
        self.name = name
    }
}

class Google: Mobile {
    
}

class Apple: Mobile {
    let wwdc = "WWDC22"
}

let mobile = Mobile(name: "phone")
let apple = Apple(name: "apple")
let google = Google(name: "google")

// is : 어떤 클래스의 인스턴스 타입, 데이터 타입인지 확인
// ex. Local Notification
mobile is Mobile
mobile is Google
mobile is Apple

apple is Mobile
apple is Apple
apple is Google

// Type Cast Operator : as(업캐스팅) / as? , as! (다운캐스팅)
// 업캐스팅 : 부모클래스 타입인걸 알 경우, 항상 성공하는 것을 아는 경우
let iphone: Mobile = Apple(name: "apple") // wwdc 프로퍼티 접근 불가능

// as? 옵셔널 반환 타입 => 실패할 경우 nil 반환
// as! 옵셔널 X => 실패할 경우 무조건 런타임 오류 발생
if let value = iphone as? Apple {
    print(value.wwdc)
}

if let value = iphone as? Google {
    print(value)
} else {
    print("타입 캐스팅 실패")
}

// iphone as! Google 런타임 오류 발생

apple as Mobile

// Any(모든 타입에 대한 인스턴스 담을 수 있음) vs Anyobject(클래스의 인스턴스만 담을 수 있음)
// 컴파일 시점에서는 어떤 타입인지 알 수 없고, 런타임 시점에 타입이 결정
var somethings: [Any] = []

somethings.append(0)
somethings.append(true)
somethings.append("something")
somethings.append(mobile)

print(somethings[1])

let example = somethings[1]

if let element = example as? Bool {
    print(element)
} else {
    print("Bool 아님")
}

/*
 MARK: Generic
 - 타입에 유연하게 대응
 - Type Parameter : 플레이스 홀더 같은 역할. 어떤 타입인지 타입의 종류는 알려주지 않음. 특정한 타입 하나라는건 알 수 있음. 제네릭으로 이루어진 함수 사용 시 T에 들어갈 타입은 모두 같아야 한다. UpperCased로 작성. ex T U K
 - Type Constraints : 클래스 / 프로토콜 제약
 */

func configureBorderLabel(_ view: UILabel) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorderButton(_ view: UIButton) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

func configureBorder<T: UIView>(_ view: T) {
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 1
}

let img = UIImageView()
let lbl = UILabel()

configureBorder(img)
configureBorder(lbl)

// T에 들어갈 타입은 모두 같아야 하므로, mainContents와 subContents의 타입을 다르게 받고 싶다면 제네릭을 여러개 써야 한다.
struct DummyData<T, U> {
    var mainContents: T
    var subContents: U
}

let cast = DummyData(mainContents: "현빈", subContents: "주인공역")
let phoneNumber = DummyData(mainContents: "고래밥", subContents: 01012341234)
let todo = DummyData(mainContents: "할일목록", subContents: true)

func total(a: [Int]) -> Int {
    return a.reduce(0, +)
}

func total(a: [Float]) -> Float {
    return a.reduce(0, +)
}

func total(a: [Double]) -> Double {
    return a.reduce(0, +)
}

total(a: [1,2,3,4,5,6,7,8,9])
total(a: [1.1, 2.2, 3.3])

// 제약조건을 통해 Any와 달리, 특정 타입(reduce 사용가능한 타입)만 받을 수 있도록 사용 가능
func total<T: Numeric>(a: [T]) -> T {
    return a.reduce(.zero, +)
}

// 화면 전환 코드
class SampleViewController: UIViewController {
    func transitionViewController<T: UIViewController>(sb: String, id: String, vc: T) {
        let sb = UIStoryboard(name: sb, bundle: nil)
        let vc = sb.instantiateViewController(identifier: id) as! T
        self.present(vc, animated: true)
    }
}

class Animal: Equatable {
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let one = Animal(name: "고양이")
let two = Animal(name: "고양이")

one.name == two.name
// one == two 연산불가 -> Equatable 프로토콜을 채용하지 않았기 때문
one == two // Animal class에서 Equatable를 채용하고, 등위연산자를 구현했기 때문에 연산 가능

var fruit1 = "사과"
var fruit2 = "바나나"
swap(&fruit1, &fruit2) // inout parameter
print(fruit1, fruit2)

func swapTwoInts<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

swapTwoInts(a: &fruit1, b: &fruit2)
print(fruit1, fruit2)




//: [Next](@next)
