//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON

// 클래스 싱글턴 패턴 vs 구조체 싱글턴 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() {}
    
    typealias completionHandler = (Int, [String]) -> Void
    
    // @escaping : 안에서 작성한 클로저가 밖에서 사용될 때 작성한다.
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = EndPoint.imageSearchURL + "query=\(text!)&display=30&start=\(startPage)" // 왜 한글만 안되지?
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let totalCount = json["total"].intValue
                
//                for i in json["items"].arrayValue {
//                    let thumbnail = i["thumbnail"].stringValue
//                    self.thumbnailList.append(thumbnail)
//                }
                
                let thumbnailList = json["items"].arrayValue.map { $0["thumbnail"].stringValue }
                
                //self.imageResultCollectionView.reloadData()
                
                completionHandler(totalCount, thumbnailList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
