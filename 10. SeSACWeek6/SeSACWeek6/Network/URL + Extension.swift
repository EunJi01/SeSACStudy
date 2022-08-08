//
//  URL + Extension.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/08.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
