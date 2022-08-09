//
//  NewTMDBViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

class NewTMDBViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    let testList: [[String]] = [
        ["A", "B", "C", "D", "E", "F", "G"],
        ["가", "나", "다", "라"],
        ["あ", "か", "さ"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
}

extension NewTMDBViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }

        cell.backgroundColor = .black
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141 + 16 + 24 + 4
    }
}

extension NewTMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.cardView.posterImageView.backgroundColor = .lightGray
        cell.cardView.testLabel.text = testList[collectionView.tag][indexPath.item]
        
        return cell
    }
}
