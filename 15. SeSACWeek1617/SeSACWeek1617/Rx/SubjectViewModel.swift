//
//  SubjectViewModel.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/25.
//

import Foundation
import RxSwift

struct Contact {
    var name: String
    var age: Int
    var number: String
}

class SubjectViewModel {
    var contactData = [
        Contact(name: "Jack", age: 21, number: "010-1234-1234"),
        Contact(name: "Hue", age: 23, number: "010-4567-4567"),
        Contact(name: "Lia", age: 24, number: "010-7890-7890")
    ]
    
    var list = PublishSubject<[Contact]>()
    
    func fetchData() {
        list.onNext(contactData)
    }
    
    func resetData() {
        list.onNext([])
    }
    
    func newData() {
        let new = Contact(name: "고래밥", age: Int.random(in: 10...50), number: "")
        
        //list.onNext([new]) // -> 덮어 쓰는 기능! 초기화와 동일
        
        contactData.append(new)
        list.onNext(contactData)
    }
    
    func filterData(query: String) {
        let result = query != "" ? contactData.filter { $0.name.contains(query) } : contactData
        list.onNext(result)
    }
}
