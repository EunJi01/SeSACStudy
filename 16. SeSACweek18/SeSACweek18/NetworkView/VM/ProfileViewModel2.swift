//
//  ProfileViewModel.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel2 {
    let api = APIService()
    
    func imageFormat(url: String) -> Data {
        guard let url = URL(string: url) else { return Data() }
        guard let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
}
