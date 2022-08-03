//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        
    }
    
    // fetchImage, requestImage, callRequestImage, getImage... -> response에 따라 네이밍을 설정해주기도 함.
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = EndPoint.imageSearchURL + "query=\(text!)&display=6&start=1" // 왜 한글만 안되지?
        
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
