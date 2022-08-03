//
//  ViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class TMDBViewController: UIViewController {

    @IBOutlet weak var contentsCollectionView: UICollectionView!
    
    var movieList: [ResponseValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        contentsCollectionView.register(UINib(nibName: ContentsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
    }
    
    func requestContents() {
        let url = endPoint.tmdbURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for i in json["results"].arrayValue {
                    let title = i["title"].stringValue
                    let image = url + i["poster_path"].stringValue
                    let overview = i["overview"].stringValue
                    let release = i["release_date"].stringValue
                    let grade = i["vote_average"].doubleValue
                    
                    print("image")
                    let data = ResponseValue(title: title, image: image, overview: overview, release: release, grade: grade)
                    self.movieList.append(data)
                }
                
                self.contentsCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        
        
        
        return cell
    }
}
