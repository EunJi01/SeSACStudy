//
//  ImageSearchAPIManager.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    private init() {}
    
    typealias completionHandler = ([String]) -> Void
    
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {

        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = Endpoint.naverSearch + "query=\(text)&display=100&start=\(startPage)" // 왜 한글만 안되지?
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")

                let imageList = json["items"].arrayValue.map { $0["thumbnail"].stringValue }
        
                completionHandler(imageList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
