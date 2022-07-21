//: [Previous](@previous)

import Foundation

// 1. 옵셔널 바인딩

// ex. 쇼핑 리스트 추가
var shoplist: String? = "신발 사기"
var shoplist2: String? = "모니터 사기"

if shoplist != nil && shoplist2 != nil {
    print("\(shoplist!), \(shoplist2!) 완료")
} else {
    print("글자를 입력해주세요")
}
// 2글자 이상을 꼭 입력해야 한다면?

// ex. 잭플릭스 로그인화면
if let lia = shoplist, let value = shoplist2, (2...6).contains(lia.count) { // shoplist: optional string type -> lia: string type
    print("\(lia), \(value) 완료!")
} else {
    print("글자를 입력해주세요")
}

func optionalBindingFunction() {
    guard let lia = shoplist else {
        print("글자를 입력해주세요")
        return // 여기서 함수 자체가 종료됨
    }
    
    print("\(lia) 완료!")
    
}

// 2. 인스턴스 프로퍼티 vs 타입 프로퍼티

class User {
    var nickname = "고래밥" //저장 프로퍼티(상수 저장 프로퍼티/변수 저장 프로퍼티), 인스턴스 프로퍼티
    static var staticNicname = "칙촉" //저장 프로퍼티(상수 저장 프로퍼티/변수 저장 프로퍼티), 타입 프로퍼티
    
}

User().nickname
let user = User() // 클래스 초기화, 인스턴스 생성
user.nickname


let user2 = User()
let user3 = User()
let user4 = User()

User.staticNicname // 호출 시 메모리에 올라감. 인스턴스를 생성한다고 해서 초기화가 되지 않고, 사용할 때 쵝화가 된다.













//: [Next](@next)
