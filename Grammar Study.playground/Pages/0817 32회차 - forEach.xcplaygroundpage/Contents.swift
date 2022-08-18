//: [Previous](@previous)

import Foundation

func forin() {
    let num = [1, 2, 3]
    for i in num {
        print(i)
        return
        //break
        print("return")
    }
    print("함수 종료")
}

forin()

func forEach() {
    let num = [1, 2, 3]
    num.forEach {
        print($0)
        return
        print($0)
    }
    print("함수 종료")
}

// forEach()

//: [Next](@next)
