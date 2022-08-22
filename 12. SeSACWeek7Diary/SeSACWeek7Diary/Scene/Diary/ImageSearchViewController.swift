//
//  ImageSearchViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/20.
//

import UIKit
import SeSAC2UIFramework
import Kingfisher

class ImageSearchViewController: BaseViewController {
    
    var mainView = ImageSearchView()
    var imageList: [String] = []
    var startPage: Int = 1
    var selectedImageURL: String?
    var selectButtonActionHandler: ((String?) -> ())?
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        mainView.searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonTapped))
    }
    
    func fetchData(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { imageList in
            self.imageList.append(contentsOf: imageList)
            
            DispatchQueue.main.async {
                self.mainView.imageCollectionView.reloadData()
            }
        }
    }
    
    @objc func selectButtonTapped() {
        selectButtonActionHandler?(selectedImageURL)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imageList[indexPath.item])
        cell.resultImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageURL = imageList[indexPath.item]
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            imageList.removeAll()
            selectedImageURL = nil
            startPage = 1
            fetchData(query: text)
            view.endEditing(true)
        }
    }
}
