import UIKit

// 매개변수가 없는 함수
func setNickname() -> Void {
    
    print("저는 고래밥입니다")
    
}

setNickname()

// 매개변수가 있는 함수
func setNicknameParameter(nickname: String) -> String {
    
    print("저는 \(nickname)입니다") // 개발자
    
    return "저는 \(nickname)입니다용"
    
}

setNicknameParameter(nickname: "칙촉")




func getGameCharacter(name: String, age: Int) -> [String] {
    
    let character = ["도적", "도사", "주술사", "전사", "변호사"]
    let select = character.randomElement()!
    
    return [name, select]
    
}

var numberSet: Set = [2, 4, 6, 8, 10]
var numberSet2: Set = [1, 2, 3, 4, 5]

// numberSet.subtract(numberSet2)  --> 반환값 없음
numberSet.subtracting(numberSet2)  //  --> 반환값 있음

print(numberSet)

var numberArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// appending
// numberArray.shuffle  --> 반환값 없음
numberArray.shuffled()  // --> 반환값 있음

print(numberArray)
