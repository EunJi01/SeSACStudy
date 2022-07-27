//: [Previous](@previous)

import Foundation

struct ExchangeRate {

    var currentKRW = 0.0
    var currencyRate: Double {
        willSet {
            print("currency Rate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet {
            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {
        willSet {
            print("USD willSet - 환전 금액: USD: \(newValue)달러로 환전될 예정")
        }
        didSet {
            print("USD didSet - KRW: \(currentKRW)원 -> \(USD)달러로 환전되었음")
        }
    }
    
    var KRW: Double {
        mutating get {
            return currentKRW
        }
        set {
            currentKRW = newValue
            USD = newValue / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000

print("실행됨")

//: [Next](@next)
