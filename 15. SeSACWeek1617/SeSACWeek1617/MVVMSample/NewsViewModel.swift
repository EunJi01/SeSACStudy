//
//  NewsViewModel.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import Foundation
import RxSwift
import RxCocoa

class NewsViewModel {
    var pageNumber = BehaviorSubject(value: "3,000")
    
    //var sample = BehaviorSubject(value: News.items)
    var sample = BehaviorRelay(value: News.items)
    
    func changePageNumberFormat(text: String) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let text = text.replacingOccurrences(of: ",", with: "")
        guard let number = Int(text) else { return }
        guard let result = numberFormatter.string(for: number) else { return }
        
        pageNumber.onNext(result)
    }
    
    func resetSample() {
        //sample.onNext([])
        sample.accept([])
    }
    
    func loadSample() {
        //sample.onNext(News.items)
        sample.accept(News.items)
    }
}
