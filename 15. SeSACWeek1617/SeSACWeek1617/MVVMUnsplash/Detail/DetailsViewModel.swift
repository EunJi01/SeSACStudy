//
//  DetailsViewModel.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import Foundation
import RxSwift

class DetailsViewModel {
    var details = PublishSubject<PhotoDetails>()
    
    func requestPhotoDetails(id: String) {
        APIService.photoDetails(id: id) { [weak self] details, statusCode, error in
            guard let details = details else { return }
            self?.details.onNext(details)
        }
    }
}
