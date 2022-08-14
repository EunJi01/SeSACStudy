//
//  OpenWeatherMapAPIManager.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/13.
//

import Foundation

import Alamofire
import SwiftyJSON
import CoreLocation

class OpenWeatherMapAPIManager {
    
    static let shared = OpenWeatherMapAPIManager()
    private init() {}
    
    func requestWeather(coordinate: CLLocationCoordinate2D, completionHandler: @escaping (JSON)-> ()) {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        let url = EndPoint.openWeatherMap + "lat=\(lat)&lon=\(lon)&appid=" + APIKey.openWeatherMap
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
