//
//  LibraryCollectionViewController.swift
//  Library
//
//  Created by 황은지 on 2022/07/20.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    static let identifire = "LibraryCollectionViewController"
    
    var movieList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .systemTeal
        
        addNavigationItem()

    }
    
    // 네비게이션 바 아이템
    func addNavigationItem() {
        navigationItem.title = "책 열람"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    // 검색 버튼
    @objc func searchButtonTapped() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: BookSearchViewController.identifire) as? BookSearchViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    // 셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: BookDetailViewController.identifire) as? BookDetailViewController else {
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 셀 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    // 셀 디자인/데이터
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifire, for: indexPath) as! LibraryCollectionViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        cell.layoutCell(view: collectionView)
        
        return cell
    }

}
