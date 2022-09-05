//: [Previous](@previous)

import UIKit

class Guild {
    var name: String
    unowned var owner: User? // 이 길드장은 누구?
    
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild deinit")
    }
}

class User {
    var name: String
    var guild: Guild? // 고래밥이 새싹 길드에 있다면?
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User(name: "고래밥") // User: RC 1
var guild: Guild? = Guild(name: "SeSAC") // Guild: RC 1

user?.guild = guild // Guild: RC 2
guild?.owner = user // User: RC 1 -> owner에 대한 RC 가 증가하지 않음

// guild = nil // Guild: RC 1
user = nil // User: RC 0 // Guild: RC 0

guild?.owner // nil // unowned일 경우 메모리 주소는 남아있음 -> 에러 발생
//user?.guild // nil

// 순환참조 중인 요소를 먼저 nil (반대도 가능) 인스턴스의 참조 관계 먼저 해제 => 수동은 어려워ㅜㅜ => weak unowned 등장!!
// user?.guild = nil // Guild: RC 1






//: [Next](@next)
