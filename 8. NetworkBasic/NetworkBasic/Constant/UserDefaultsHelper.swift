//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    private init() {}
    
    static let standard = UserDefaultsHelper()
    // singleton patton 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age, lotto
    }
    
    var nickname: String? {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set { // 연산 프로퍼티 parameter
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    var lotto: Int {
        get {
            return userDefaults.integer(forKey: Key.lotto.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.lotto.rawValue)
        }
    }
}
