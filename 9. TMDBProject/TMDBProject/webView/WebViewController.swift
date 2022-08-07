//
//  WebViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/05.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var movidId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestVideo(movieId: movidId)
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "MT MEDIA"
        view.backgroundColor = CustomColor.apricot
    }
    
    func openWebPage(videoId: String) {
        guard let url = URL(string: endPoint.youtubeVideoURL + videoId) else {
            print("Invalid URL")
            return
        }
        print(url)
        webView.load(URLRequest(url: url))
    }
    
    func requestVideo(movieId: Int) {
        let url = endPoint.tmdbVideoURL + "\(movidId)/" + "videos?api_key=" + APIKey.TMDB + "&language=en-US"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let videoId = json["results"][0]["key"].stringValue
                self.openWebPage(videoId: videoId)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
