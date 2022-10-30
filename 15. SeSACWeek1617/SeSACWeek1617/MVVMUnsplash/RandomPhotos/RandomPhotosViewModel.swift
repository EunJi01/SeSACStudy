//
//  RandomPhotosViewModel.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/29.
//

import Foundation
import RxSwift
import RxCocoa

class RandomPhotosViewModel {
    var randomPhotos = PublishSubject<RandomPhotos>()
    
    func requestRandomPhotos() {
        APIService.randomPhotos { [weak self] randomPhotos, statusCode, error in
            guard let randomPhotos = randomPhotos else { return }
            self?.randomPhotos.onNext(randomPhotos)
        }
    }
}
