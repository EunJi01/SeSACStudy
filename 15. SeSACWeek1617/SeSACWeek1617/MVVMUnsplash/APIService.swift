//
//  APIService.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/20.
//

import Foundation
import Alamofire

class APIService {
    private init() { }
    
    static func searchPhoto(query: String, completion: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.searchURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
        }
    }
    
    static func photoDetails(id: String, completion: @escaping (PhotoDetails?, Int?, Error?) -> Void) {
        let url = "\(APIKey.baseURL)/photos/\(id)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: PhotoDetails.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
        }
    }
    
    static func randomPhotos(completion: @escaping (RandomPhotos?, Int?, Error?) -> Void) {
        let url = "\(APIKey.baseURL)/photos/random"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: RandomPhotos.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
                print("성공")
            case .failure(let error): completion(nil, statusCode, error)
                print("실패")
                print("\(error)")
            }
        }
    }
}
