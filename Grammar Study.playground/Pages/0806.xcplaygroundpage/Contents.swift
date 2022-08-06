//: [Previous](@previous)

import Foundation

var winningList: [Int: [Int]] = [:]

for drwNo in 1...6 {
    
    var winningNoList: [Int] = []
    
    for winningNo in 1...6 {
        winningNoList.append(winningNo)
    }
    
    winningList.updateValue(winningNoList, forKey: drwNo)
}

winningList.map { print($0) }

//: [Next](@next)
