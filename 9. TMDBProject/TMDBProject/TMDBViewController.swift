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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        requestContents()
        layout()
    }
    
    @objc
    func leftBarButtonTapped() {
    }
    
    @objc
    func rightBarButtonTapped() {
    }
    
    func requestContents() {
        let url = endPoint.tmdbURL + "api_key=" + APIKey.TMDB
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                print(json["results"]["title"].stringValue)
                for i in 0...9 {
                    let j = json["results"][i]
                    
                    let title = j["title"].stringValue
                    let image = url + j["poster_path"].stringValue
                    let overview = j["overview"].stringValue
                    let release = j["release_date"].stringValue
                    let grade = j["vote_average"].doubleValue
                    
                    //print(title)
                    let data = ResponseValue(title: title, image: "", overview: overview, release: release, grade: grade)
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
        
        cell.contentTitleLabel.text = movieList[indexPath.row].title
        //cell.contentsImageView = movieList[indexPath.row].image
        cell.contentsOverviewLabel.text = movieList[indexPath.row].overview
        cell.contentsReleaseLabel.text = movieList[indexPath.row].release
        cell.contentsGradeScoreLabel.text = String(format: "%.1f", movieList[indexPath.row].grade)
        
        // =============================================나중에 밖으로 뺴기=================================================//
        cell.insertSubview(cell.shadowView, belowSubview: cell.contentsImageView)
        cell.shadowView.backgroundColor = .black
        cell.shadowView.layer.shadowRadius = 10
        
        cell.contentsBackgroundView.backgroundColor = .white
        cell.contentsBackgroundView.layer.cornerRadius = 10
        cell.contentsBackgroundView.clipsToBounds = true
        
        cell.clipButton.setTitle("", for: .normal)
        cell.clipButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        cell.clipButton.tintColor = .white
        cell.viewMoreButton.setTitle("자세히 보기", for: .normal)
        cell.viewMoreButton.titleLabel?.tintColor = .darkGray
        cell.viewMoreIconButton.setTitle("", for: .normal)
        cell.viewMoreIconButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        cell.viewMoreIconButton.tintColor = .darkGray
        
        cell.contentsGradeTextLabel.text = "평점"
        cell.contentsGradeTextLabel.textColor = .white
        cell.contentsGradeTextLabel.backgroundColor = .systemIndigo
        cell.contentsGradeScoreLabel.backgroundColor = .white
        
        cell.contentsReleaseLabel.textColor = .lightGray
        cell.contentsOverviewLabel.textColor = .darkGray
        
        cell.emptyLabel.font = .boldSystemFont(ofSize: 16)
        return cell
    }
    
    func layout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        
        self.contentsCollectionView.collectionViewLayout = layout
    }
}
