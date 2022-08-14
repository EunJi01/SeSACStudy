//
//  Endpoint.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/08.
//

import Foundation

struct EndPoint {
    private init() {}
    
    static let clova = "https://openapi.naver.com/v1/vision/celebrity"
    static let openWeatherMap = "https://api.openweathermap.org/data/2.5/weather?"
    static let weatherImage = "https://openweathermap.org/img/wn/"
}

// enum에서 저장 프로퍼티는 못 쓰고 연산 프로퍼티는 쓸 수 있는 이유?
enum KakaoEndpoint {
    case blog
    case cafe
    
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case .cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}
