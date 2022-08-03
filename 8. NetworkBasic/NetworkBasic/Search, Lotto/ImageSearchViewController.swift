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
    
    @IBOutlet weak var imageResultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageResultCollectionView.delegate = self
        imageResultCollectionView.dataSource = self
        imageResultCollectionView.register(UINib(nibName: ImageSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.identifier)
        
        layout()
        fetchImage()
    }
    
    var thumbnailList: [String] = []
    
    // fetchImage, requestImage, callRequestImage, getImage... -> response에 따라 네이밍을 설정해주기도 함.
    func fetchImage() {
        let text = "레서판다".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = EndPoint.imageSearchURL + "query=\(text!)&display=50&start=1" // 왜 한글만 안되지?
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for i in json["items"].arrayValue {
                    let thumbnail = i["thumbnail"].stringValue
                    self.thumbnailList.append(thumbnail)
                }

                self.imageResultCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func layout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2
        let width = UIScreen.main.bounds.width - (spacing * 5)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        
        imageResultCollectionView.collectionViewLayout = layout
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageResultCollectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.identifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        let imageURL = URL(string: thumbnailList[indexPath.row])
        cell.resultImageView.kf.setImage(with: imageURL)
        
        return cell
    }
}
