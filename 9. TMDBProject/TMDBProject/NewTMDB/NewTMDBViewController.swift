//
//  NewTMDBViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

import Kingfisher

class NewTMDBViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    var recommendationsList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        navigationItem.title = "이런 영화는 어떠세요?"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        TMDBAPIManager.shared.requestImage { posterList in
            self.recommendationsList = posterList
            self.movieTableView.reloadData()
            dump(self.recommendationsList)
        }
    }
}

extension NewTMDBViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }

        tableView.backgroundColor = .clear
        cell.titleLabel.text = TMDBAPIManager.shared.movieList[indexPath.row].0 + " 와 비슷한 영화"
        cell.backgroundColor = .black
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.tag = indexPath.row
        cell.movieCollectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141 + 16 + 24 + 4
    }
}

extension NewTMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationsList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let url = EndPoint.tmdbImageURL + recommendationsList[collectionView.tag][indexPath.item]
        cell.cardView.posterImageView.kf.setImage(with: URL(string: url))
        
        return cell
    }
}
