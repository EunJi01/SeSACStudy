//
//  SubscriptExample.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/03.
//

import Foundation

extension String {
    // 문자열 서브스크립트 구현 (+ 옵셔널 대응)
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else { return nil }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}

extension Collection {
    // 안전한 서브스크립트 구현 (옵셔널 대응)
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct Phone {
    // 구조체의 특정 프로퍼티에 대한 서브스크립트 구현
    var numbers = ["0102", "1005", "0126", "0326"]
    
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        }
        set {
            self.numbers[idx] = newValue
        }
    }
}
