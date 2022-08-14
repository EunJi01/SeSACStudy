//
//  ClovaAPIManager.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/13.
//

import Foundation

import Alamofire
import SwiftyJSON
import UIKit

class ClovaAPIManager {
    
    static let shared = ClovaAPIManager()
    
    private init() {}
    
    func clovaImageUpload(image: UIImage?, completionHandler: @escaping (JSON)-> () ) {
        let url = EndPoint.clova
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET,
            //"Content-Type": "multipart/form-data" 라이브러리에 내장되어 있기 때문에 안해도 됨
        ]
        
        // UIImage를 텍스트 형태 (바이너리 타입) 로 변환해서 전달
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {
            return print("이미지가 큼")
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: url, headers: header)
            .validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")

                completionHandler(json["faces"][0]["celebrity"])
            case .failure(let error):
                print(error)
            }
        }
    }
}
