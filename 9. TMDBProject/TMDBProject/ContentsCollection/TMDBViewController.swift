//
//  ViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/03.
//

import UIKit

import Alamofire
import JGProgressHUD
import Kingfisher
import SwiftyJSON

class TMDBViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let hud = JGProgressHUD()
    
    var movieList: [MovieValue] = []
    var genreDictionary: [Int: String] = [:]
    var movieNumber = 0
    let lastMovieNumber = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ContentsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        view.backgroundColor = CustomColor.apricot
        collectionView.backgroundColor = CustomColor.apricot
        requestContents()
        requestGenre()
        layout()
    }
    
    @objc
    func leftBarButtonTapped() {
    }
    
    @objc
    func rightBarButtonTapped() {
    }
    
    func requestContents() {
        hud.show(in: self.view)
        
        guard movieNumber != lastMovieNumber else { return }
        self.movieNumber += 5
        
        TMDBAPIManager.shared.requestContentsData(movieNumber: movieNumber, movieList: movieList) { newMovieList in
            self.movieList.append(contentsOf: newMovieList)
            //print("무비리스트 업뎃")
            
            DispatchQueue.main.async {
                //print("리로드")
                print("=======moveiNumber\(self.movieNumber)=======")
                self.collectionView.reloadData()
                self.hud.dismiss()
            }
        }
    }
    
    func requestGenre() {
        TMDBAPIManager.shared.requestGenreData { genreDictionary in
            self.genreDictionary = genreDictionary
            //print("장르 업뎃")
        }
    }
}

extension TMDBViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffset_y = scrollView.contentOffset.y
        let collectionViewContentSize = collectionView.contentSize.height
        let pagination_y = collectionViewContentSize * 0.5
        
        if contentOffset_y > pagination_y && movieNumber < lastMovieNumber {
            requestContents()
            collectionView.reloadData()
            //print("=======moveiNumber\(movieNumber)=======")
        }
    }
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: StoryboardName.main, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: CastViewController.reuseIdentifier) as? CastViewController else { return }

        vc.movieData = movieList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieNumber < lastMovieNumber {
            return movieList.count
        } else {
            return lastMovieNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        // 위치 : VC cellForItemAt
        // 3. 위임하기
        cell.delegate = self
        cell.index = indexPath.row
        
        let imageURL = URL(string: movieList[indexPath.row].image)
        
        cell.contentTitleLabel.text = movieList[indexPath.row].title
        cell.contentsImageView.kf.setImage(with: imageURL)
        cell.contentsOverviewLabel.text = movieList[indexPath.row].overview
        cell.contentsReleaseLabel.text = movieList[indexPath.row].release
        cell.contentsGradeScoreLabel.text = String(format: "%.1f", movieList[indexPath.row].grade)
        if let genreStr = genreDictionary[movieList[indexPath.row].genreId] {
            cell.contentsGenreLabel.text = "# " + genreStr
        }
        
        // =============================================나중에 밖으로 뺴기=================================================//
        
        cell.contentsBackgroundView.backgroundColor = .white
        cell.contentsBackgroundView.layer.cornerRadius = 10
        cell.contentsBackgroundView.clipsToBounds = true
        
        cell.webButton.setTitle("", for: .normal)
        cell.webButton.setImage(UIImage(systemName: "paperclip.circle.fill"), for: .normal)
        cell.webButton.tintColor = .white
        cell.viewMoreButton.setTitle("자세히 보기", for: .normal)
        cell.viewMoreButton.titleLabel?.tintColor = .darkGray
        cell.viewMoreIconButton.setTitle("", for: .normal)
        cell.viewMoreIconButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        cell.viewMoreIconButton.tintColor = .darkGray
        
        cell.contentsGradeTextLabel.text = "평점"
        cell.contentsGradeTextLabel.textColor = .white
        cell.contentsGradeTextLabel.backgroundColor = .systemIndigo
        cell.contentsGradeScoreLabel.backgroundColor = .white
        cell.contentsGenreLabel.font = .boldSystemFont(ofSize: 20)
        
        cell.contentsReleaseLabel.textColor = .lightGray
        cell.contentsOverviewLabel.textColor = .darkGray
        
        return cell
    }
    
    func layout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        
        self.collectionView.collectionViewLayout = layout
    }
}

// 위치 : VC
// 4. 버튼 동작 구현하기
extension TMDBViewController: WebButtonDelegate {
    func webButtonTapped(index: Int) {
        print("\(index)번째 웹버튼 탭됨")
        
        let sb = UIStoryboard(name: StoryboardName.main, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: WebViewController.reuseIdentifier) as? WebViewController else { return }
        vc.movidId = movieList[index].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
