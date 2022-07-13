//: [Previous](@previous)

import Foundation

// 상속, override는 classd에서만 가능하다
class Monster {
    var clothes = "Orange + Christmas"
    var speed = 5
    var power = 20
    var expoint: Double = 5000


    func attack() {
        print("공격!!!")
    }
}

var nickname = "고래밥" // 초기화
var easyMonster = Monster() // 초기화(인스턴스)
easyMonster.clothes
easyMonster.power

easyMonster.attack()
easyMonster.attack()

class BossMonster: Monster {
    var levelLimit = 500
    
    func bossAttack() {
        print("스페셜 공격")
    }
    
    // 재정의
    override func attack() {
        super.attack()
        print("오버라이드 공격!")
    }
}

// 구조체는 값 타입, 클래스는 참조 타입

var finalBoss = BossMonster()
finalBoss.bossAttack()
finalBoss.levelLimit
finalBoss.speed
finalBoss.clothes
finalBoss.attack()

// =======구조체라면?========
var nickname2 = "고래밥"

var subNickname = nickname

subNickname = "칙촉"

print(nickname2) // 고래밥
print(subNickname) // 칙촉

// =======class라면?========
var miniMonster = Monster()

var bossMonster = miniMonster

bossMonster.power = 5000

print(miniMonster.power)
print(bossMonster.power)




//: [Next](@next)
