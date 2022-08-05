//: [Previous](@previous)

import Foundation

/*
 MARK: 클로저 : 이름 없는 함수
 */

// () -> ()
func studyiOS() {
    print("주말에도...공부...하기...")
}


let studyiOSHarder: () -> () = {
    print("주말에도...공부...하기...")
}

// '클로저 헤더' in '클로저 바디'
let studyiOSHarder2 = { () -> () in
    print("주말에도...공부...하기...")
}

studyiOSHarder2()

func getStudyWithMe(study: () -> () ) {
    print("getStudyWithMe")
    study()
}

// 코드를 생략하지 않고 클로저 구문 씀. 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// => 인라인(Inline) 클로저
getStudyWithMe(study: { () -> () in
    print("주말에도...공부...하기...")
})

// 함수 뒤에 클로저가 실행
// => 트레일링(후행) 클로저
getStudyWithMe() { () -> () in
    print("주말에도...공부...하기...")
}

//func example(number: Int) -> String {
//    return "\(number)"
//}

func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

// 인라인 클로저
randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다."
})

// 매개변수가 생략되면 할당되어 있는 내부 상수 $0 을 사용할 수 있다. ($0, $1, $2...)
randomNumber() {
    "행운의 숫자는 \($0)입니다."
}

randomNumber { "\($0)" }

// MARK: 고차함수 : filter map reduce

func processTime(code: () -> () ) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}

// ex. 4.0 이상인 학생 고르기
let student = [2.2, 4,5, 3.2, 4.9, 1.8, 3.2, 3.3, 4.5]
var newStudent: [Double] = []

processTime {
    for student in student {
        if student >= 4.0 {
            newStudent.append(student)
        }
    }
}

print(newStudent)

let filerStudent = student.filter { value in
    value >= 4.0
}

processTime {
    let filerStudent2 = student.filter { $0 >= 4.0 } // 클로저 축약 사용
    
    print(filerStudent2)
}

// map: 기존 요소를 클로저를 통해 원하는 결과값으로 변경
let number = [Int](1...100)

var newNumber: [Int] = []

for number in number {
    newNumber.append(number * 3)
}
print(newNumber)

let mapNumber = number.map { $0 * 3 }
print(mapNumber)

let movieList = [
    "a": "에이",
    "b": "비",
    "c": "씨",
    "aa": "에이"
]

// 특정 value의 key만 출력
let movieResult = movieList.filter { $0.value == "에이" }

// 배열로 변환
let movieResult2 = movieList.filter { $0.value == "에이" }.map { $0.key }
print(movieResult2)

// reduce

let examScore: [Double] = [100, 20, 40, 77, 75, 91, 80, 95]

var totalCount: Double = 0

for score in examScore {
    totalCount += score
}

print(totalCount / 8)

let totalCountUsingReduce = examScore.reduce(0) { $0 + $1 }

print(totalCountUsingReduce / 8)

// drawingGame: 외부함수, luckyNumber: 내부함수
func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...10))"
    }
    
    let result = luckyNumber(number: item) // 내부 함수의 생명 주기가 끝난다
    return result
}

drawingGame(item: 10) // 외부 함수의 생명 주기가 끝난다

// 내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> () -> String {
    
    func luckyNumber() -> String {
        return "\(item * Int.random(in: 1...10))"
    }
    
    return luckyNumber
}

drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않음

let numberResult = drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않음. 외부 함수 생명주기가 끝났음
numberResult() // 외부 함수의 생명주기가 끝났는데 내부 함수는 사용이 가능한 상황이 됨

// 은닉성()이 있는 내부 함수를 외부함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근 가능하게 되었음
// 이제 얼마든지 호출이 가능. 이건 생명주기에도 영향을 미침. 외부 함수가 종료되더라도 내부 함수는 살아있음

// 드디어..! 클로저를 봅시다
// 같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨
// 클로저에 의해 내부 함수 주변의 지역변수나 상수도 함께 저장됨 -> 값이 캡쳐되었다고 표현함 => 캡쳐리스트 => weak, strong, unowned
// 주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일때 사용함. 클로저 캡쳐 기본 기능임



//: [Next](@next)
