//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/03.
//

import UIKit

import Alamofire
import JGProgressHUD
import SwiftyJSON

class ImageSearchViewController: UIViewController {
    
    @IBOutlet weak var imageResultCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // 네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var totalCount = 0
    var thumbnailList: [String] = []
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        imageResultCollectionView.delegate = self
        imageResultCollectionView.dataSource = self
        imageResultCollectionView.prefetchDataSource = self
        imageResultCollectionView.register(UINib(nibName: ImageSearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.identifier)
        
        layout()
    }
    
    // fetchImage, requestImage, callRequestImage, getImage... -> response에 따라 네이밍을 설정해주기도 함.
    func fetchImage(query: String) {
        hud.show(in: self.view)
        
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, thumbnailList in
            self.totalCount = totalCount
            self.thumbnailList.append(contentsOf: thumbnailList)
            print(totalCount, thumbnailList)
            
            DispatchQueue.main.async {
                self.imageResultCollectionView.reloadData()
                self.hud.dismiss()
            }
        }
    }
    
    func layout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        
        imageResultCollectionView.collectionViewLayout = layout
    }
    
    // 페이지네이션 방법1. 컬렉션뷰가 특성 셀을 그리려는 시점에 호출되는 메서드
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기가 어려움
    // 권장하는 방식은 아님
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    // 페이지네이션 방법2. UIScrollViewDelegateProtoco
    // 보편적으로 많이 사용하는 방법
    // 테이블뷰/컬렉션뷰는 스크롤뷰를 상속받고 있어서, 스크롤뷰 프로토콜을 사용할 수 있음
    // 스크롤 될 때마다 감지
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    // 검색 버튼 클릭 시 실행 (키보드 리턴 키). 검색 단어가 바뀔 수 있음
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            thumbnailList.removeAll()
            startPage = 1
            //fetchImage(query: text)
        }
    }
    
    // 취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        thumbnailList.removeAll()
        imageResultCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

// 페이지네이션 방법3.
// 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음
// iOS10 이상, 스크롤 성능 향상됨
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if thumbnailList.count - 1 == indexPath.item && thumbnailList.count < totalCount {
                startPage += 30
                
                fetchImage(query: searchBar.text!)
            }
        }
        print("===\(indexPaths)")
    }
    
    // 작업을 취소할 때 (ex. 사용자가 매우 빠르게 스크롤)
    // 취소하는 기능은 직접 구현해야 함
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
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
