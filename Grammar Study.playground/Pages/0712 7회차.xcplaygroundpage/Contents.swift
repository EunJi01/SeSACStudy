import UIKit

// 0712 7회차
// RawString
var name = "RawString"
var sayHello = #"안녕하세요! \#n저는 \#(name)입니다."#
print(sayHello)


// RawValue
enum AppleDevice: String {
    case iPhone = "13핑크"
    case mac = "m1에어"
    case iPad = "에어5"
}

print(AppleDevice.iPhone.rawValue)

enum AppleDevice2: Int {
    case watch = 50
    case airPods = 20
}

print(AppleDevice2.watch)


// Tuple
let tuple = (name: "은지", 24, iPhone: 13)
print(tuple.name)
print(tuple.1)
print(tuple.iPhone)
print(tuple.2)
