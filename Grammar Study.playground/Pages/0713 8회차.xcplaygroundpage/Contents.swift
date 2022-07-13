//: [Previous](@previous)

import Foundation

// 0713 8회차

var a: String

class b {
    var c: String
    
    init(c: String) {
        self.c = c
    }
}

struct d {
    var e: String
}



// Formatted

func dateFormatStyle() {
    
    let value = Date()
    
    value
    
    print(value)
    print(value.formatted())
    print(value.formatted(date: .omitted, time: .shortened))
    print(value.formatted(date: .complete, time: .shortened))
    
    print("============================================")
    
    let locale = Locale(identifier: "ko-KR")
    
    let result = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
    print(result)
    
    let result2 = value.formatted(.dateTime.day().month(.twoDigits).year())
    print(result2)
    
    print("끝")
}

dateFormatStyle()


//: [Next](@next)
