//: [Previous](@previous)

import UIKit

enum DrinkSize {
    case short, tall, grande, venti
}

class DrinkClass {
    let name: String
    var count: Int
    var size: DrinkSize
    
    // 클래스는 초기화 구문이 필요!
    init(name: String, count:Int, size: DrinkSize) {
        self.name = name
        self.count = count
        self.size = size
    }
}

struct DrinkStruct {
    let name: String
    var count: Int
    var size: DrinkSize
}

let drinkClass = DrinkClass(name: "스무디", count: 2, size: .venti)
drinkClass.count = 5
drinkClass.size = .tall

print(drinkClass.name, drinkClass.count, drinkClass.size)

var drinkStruct = DrinkStruct(name: "스무디", count: 2, size: .grande)
drinkStruct.count = 10
drinkStruct.size = .venti

print(drinkStruct.name, drinkStruct.count, drinkStruct.size)

// 영화 타이틀, 러닝타임, 영상/화질 좋은 포스터 ==> 필요한 시점에 초기화를 할 수 없을까? ==> lazy
struct Poster {
    var image: UIImage = UIImage(named: "star") ?? UIImage()
    
    init() {
        print("Poster Initialized")
    }
}

struct MediaInfo {
    var mediaTitle: String
    var mediaRuntime: Int
    lazy var mediaPoster: Poster = Poster() // let  값 안바뀐다! 상수는 인스턴스가 생성되기 전에 값을 항상 가지고 있어야 함. 지연 저장 프로퍼티가 처음으로 호출 되서 사용하기 전에는 값 nil
}

var media = MediaInfo(mediaTitle: "오징어게임", mediaRuntime: 123) // 무조건 var

// 100중 1 play

media.mediaPoster // 저장을 지연시킴

// 타입 프로퍼티 : 지연 저장 프로퍼티 형태로 기본적으로 동작. lazy 안 써도 된다!
struct User {
    static let name = "고래밥"
    static let age = 33
}

User.name // 호출하는 시점에 메모리에 올라간다.

//: [Next](@next)
