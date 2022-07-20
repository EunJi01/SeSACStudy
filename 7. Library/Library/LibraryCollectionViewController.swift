//
//  LibraryCollectionViewController.swift
//  Library
//
//  Created by 황은지 on 2022/07/20.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    var movieList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .black

    }
    
    // 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    // 셀 디자인/데이터
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryCollectionViewCell", for: indexPath) as! LibraryCollectionViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        cell.layoutCell(view: collectionView)
        
        return cell
    }
    
    
}
