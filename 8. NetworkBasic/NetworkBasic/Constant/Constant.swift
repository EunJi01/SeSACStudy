//
//  Constant.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/01.
//

import Foundation

//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

// StoryboardName.Main.rawValue

struct StoryboardName {

    // 접근제어를 통해 초기화 방지
    private init() {
        
    }

    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

// StoryboardName.main

/*
 1. struct type property vs enum type property => 인스턴스 생성 방지
 2. enum case vs enum static => 중복, case 제약
 */

enum FontName {
    //var nickname = "고래밥" -> 사용 불가(인스턴스를 만들 수 없기 때문)
    //static var nickname = "고래밥"

    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
    
}
