//
//  DetailsViewModel.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import Foundation

class DetailsViewModel{
    var details: CObservable<PhotoDetails> = CObservable(PhotoDetails(id: "", description: "", likes: nil))
    
    func requestPhotoDetails(id: String) {
        APIService.photoDetails(id: "gKXKBY-C-Dk") { details, statusCode, error in
            guard let details = details else { return }
            self.details.value = details
        }
    }
}
