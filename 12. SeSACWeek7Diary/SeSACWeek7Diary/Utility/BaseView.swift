//
//  BaseView.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class BaseView: UIView {
    
    // 코드 베이스 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    // xib storyboard 호출 (coder : 인코딩같은 과정)
    // 코드베이스로 구현할 때에는 필요 없는 코드지만, 프토토콜이기 때문에 강제로 호출해야 하며, 이 경우 문제가 일어나지 않도록 init? 으로 호출
    required init?(coder: NSCoder) {
        // super.init(coder: coder) -> 아래의 fatalError 써도 됨
        fatalError("init(coder:) has not been implemented") // 무조건 런타임 오류
    }
    
    func configure() {}
    
    func setConstraints() {}
}

/*
// required initializer
// 초기화가 프로토콜 안에 구현되어 있다면 앞에 required 키워드가 붙는다
protocol example {
    init(name: String)
}

class Mobile: example {
    let name: String
    
    required init(name: String) {
        self.name = name
    }
}

class Apple: Mobile {
    let wwdc: String
    
    init(wwdc: String) {
        self.wwdc = wwdc
        super.init(name: "모바일")
    }
    
    required init(name: String) {
        fatalError("init(name:) has not been implemented")
    }
}

let a = Apple(name: "애플")
*/
