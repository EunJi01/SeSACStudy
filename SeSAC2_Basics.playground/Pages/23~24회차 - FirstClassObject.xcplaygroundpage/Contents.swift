//: [Previous](@previous)

import Foundation

// 함수, 일급 객체, 클로저

/*
 MARK: 1급 객체
 1. 변수나 상수에 함수를 대입할 수 있다.
 2. 함수의 반환 타입으로 함수를 사용할 수 있다.
 3. 함수의 인자로 함수를 사용할 수 있다.
 */

func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ? true : false
}

// 변수나 상수에 함수를 실행해서 반환된 반환값을 대입한 것(1급 객체의 특성은 아님)
let checkResult = checkBankInformation(bank: "우리") // checkResult Bool
print(checkResult)

// 변수나 항수에 함수 '자체'를 대입할 수 있다(1급 객체의 특성)
// 단지 함수만 대입한 것으로, 실행된 상태는 아님
let checkAccount = checkBankInformation
// 함수를 호출을 해주어야 실행 된다.
checkAccount("신한")


// Swift3 괄호 명시
// (String) -> Bool // 이게 뭐야? Function Type (ex. Tuple)
let tupleExample = (1, 2, "Hello", true)
tupleExample.2

// Function Type: (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

// Function Type: (String, Int) -> String
func hello(nickname: String, age: Int) -> String {
    return "저는 \(nickname), \(age)살 입니다."
}

// 오버로딩 특성으로 함수를 구분하기 힘을 때, 타입 어노테이션을 통해서 함수를 구별할 수 있다.
// 하지만 타입 어노테이션만으로 함수를 구별할 수 없는 상황도 있다.
// 함수 표기법을 사용한다면 타입 어노테이션을 생략하더라도 함수를 구별할 수 있다.
let result: (String) -> String = hello(username:)
result("고래밥")

let ageResult: (String, Int) -> String = hello
ageResult("고래밥", 30)

func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다."
}

let result2 = hello(username:) // 함수 표기법
result2("상어밥")

// 2-1. Calculate

func plus(a: Int, b: Int) -> Int { // (Int, Int) -> Int
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

calculate(operand: "+") // 함수가 실행되고 있는 상태가 아님
calculate(operand: "/")(10, 2)

let resultCalculate = calculate(operand: "-")
resultCalculate(12, 2)

// 2. 함수의 반환 타입으로 함수를 사용할 수 있다.
func currentAccount() -> String {
    return "계좌 있음"
}

func noCurrentAccount() -> String {
    return "계좌 없음"
}

// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount // 함수를 호출하는 것은 아니고 함수를 던져줌!
}

let jack = checkBank(bank: "농협")
jack()

checkBank(bank: "우리")()

// 3. 함수의 인자로 함수를 사용할 수 있다.
// Function () -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func plusNumber() {
    
}

func minusNumber() {
    
}

func resultNumber(number: Int, odd: () -> (), even: () -> () ) {
    return number.isMultiple(of: 2) ? even() : odd()
}

// 매개변수로 함수를 전달한다.
resultNumber(number: 9, odd: oddNumber, even: evenNumber)

resultNumber(number: 10, odd: plusNumber, even: minusNumber) // 의도 하지 않은 함수가 들어갈 수 있음. 필요 이상의 함수가 자꾸 생김

resultNumber(number: 11) { // 이름 없는 함수(익명함수) = 클로저
    print("홀수")
} even: {
    print("짝수")
}


//: [Next](@next)
