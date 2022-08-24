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
    //var selectButtonActionHandler: ((String?) -> ())?
    var selectImage: UIImage?
    var delegate: SelectImageDelegate?
    var selectIndexPath: IndexPath? // 셀 선택했을 때 UI 바꿔주는 또 다른 방법
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonTapped))
        
        // 팁 - 서버 통신이 완료되기 전 클릭 방지, 완료된 후 true로 전환
//        view.isUserInteractionEnabled = false
//        mainView.imageCollectionView.isUserInteractionEnabled = false
    }
    
    func fetchData(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { imageList in
            self.imageList.append(contentsOf: imageList)
            
            DispatchQueue.main.async {
                self.mainView.imageCollectionView.reloadData()
            }
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonTapped() {
        //selectButtonActionHandler?(selectedImageURL)
        guard let selectImage = selectImage else {
            showAlertMessage(title: "사진을 선택해주세요", button: "확인")
            return
        }
        delegate?.sendImageData(Image: selectImage)
        dismiss(animated: true)
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
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.systemPink.cgColor : nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedImageURL = imageList[indexPath.item]
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        selectImage = cell.resultImageView.image
        
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
    
    // 과제...?????
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        selectIndexPath = nil
        selectImage = nil
        collectionView.reloadData()
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            imageList.removeAll()
            //selectedImageURL = nil
            startPage = 1
            fetchData(query: text)
            view.endEditing(true)
        }
    }
}
