//: [Previous](@previous)

import Foundation

class User {
    var nickname = "Lia"
    
//    lazy var introduce = {
//        return "저는 \(self.nickname)입니다"
//    }()
    
    lazy var introduce = { [weak self] in
        return "저는 \(self?.nickname ?? "손님")입니다"
    }()
    
    init() {
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User()
user?.introduce
user = nil

func myClosure() {
    var number = 0
    print("1: \(number)")
    
    let closuer: () -> Void = { [number] in // 값 캡쳐
        print("closure: \(number)")
    }
    
    closuer()
    
    number = 100
    print("2: \(number)")
    
    closuer()
}

myClosure()







//: [Next](@next)
