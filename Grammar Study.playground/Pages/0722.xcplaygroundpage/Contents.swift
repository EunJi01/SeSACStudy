//: [Previous](@previous)

import UIKit

//UserDefaults.standard.bool(forKey: "First")


//var change: Bool?
//
//if change == true {
//    print("트루")
//} else {
//    print("폴스")
//}
//
//static var a = 1
//
//a = 2
//
//print(a)

let formatter = DateFormatter()
formatter.dateFormat = "yyyyMMdd E"

let currentDate = formatter.string(from: Date())
print(currentDate)

//: [Next](@next)
