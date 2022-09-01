//
//  PersonViewModel.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/08/31.
//

import Foundation // MVVM에서 UIKit은 VC에서만 사용한다.

class PersonViewModel { // 양방향 전달을 위해 Observable에 Person 담기 (직접 만든 클래스)
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: query) { person, error in
            guard let person = person else { return }
            //dump(person)
            self.list.value = person
        }
    }
    
    var numberOfRowsInSection: Int { // 변수명 자유
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
}
