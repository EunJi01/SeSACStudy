//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/01.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestBeer()
    }
    
    @IBAction func randomBeerButtonTapped(_ sender: UIButton) {
        requestBeer()
    }
    
    func requestBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                guard let name = json[0]["name"].string else { return }
                guard let url = json[0]["image_url"].string else { return }
                guard let description = json[0]["description"].string else { return }
                print("====random: \(name), \(url), \(description)")
                
                let imageURL = URL(string: url)
                
                self.beerNameLabel.text = name
                self.beerImageView.kf.setImage(with: imageURL)
                self.beerDescriptionLabel.text = description
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
