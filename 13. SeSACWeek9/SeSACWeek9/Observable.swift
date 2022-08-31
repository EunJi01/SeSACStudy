//
//  Observable.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/08/31.
//

import Foundation

class Observable<T> { // 양방향 바인딩
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value) // bind에서 저장한 클로저를 실행
        }
    }
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value) // 전달받은 closure를 실행만 함
        listener = closure // 다음부터는 알아서 실행되도록 저장
    }
}

//class User {
//    private var listener: ((String) -> Void)?
//
//    var value: String {
//        didSet {
//            print("데이터 바뀌었음")
//            listener?(value)
//        }
//    }
//
//    init(value: String) {
//        self.value = value
//    }
//}
