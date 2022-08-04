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

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList: [ResponseValue] = []
    var movieNumber = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ContentsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
        
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
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                //print(json["results"]["title"].stringValue)
                for i in self.movieList.count...self.movieNumber {
                    let j = json["results"][i]
                    
                    let title = j["title"].stringValue
                    let image = endPoint.tmdbImageURL + j["poster_path"].stringValue
                    let overview = j["overview"].stringValue
                    let release = j["release_date"].stringValue
                    let grade = j["vote_average"].doubleValue
                    
                    let data = ResponseValue(title: title, image: image, overview: overview, release: release, grade: grade)
                    self.movieList.append(data)
                }
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TMDBViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = collectionView.contentSize.height
        let pagination_y = collectionViewContentSize * 0.8
        
        if contentOffset_y > pagination_y {
            movieNumber += 5
            requestContents()
            print("moveiNumber\(movieNumber)")
        }
    }
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        let imageURL = URL(string: movieList[indexPath.row].image)
        
        cell.contentTitleLabel.text = movieList[indexPath.row].title
        cell.contentsImageView.kf.setImage(with: imageURL)
        cell.contentsOverviewLabel.text = movieList[indexPath.row].overview
        cell.contentsReleaseLabel.text = movieList[indexPath.row].release
        cell.contentsGradeScoreLabel.text = String(format: "%.1f", movieList[indexPath.row].grade)
        
        // =============================================나중에 밖으로 뺴기=================================================//
        
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
        
        self.collectionView.collectionViewLayout = layout
    }
}
