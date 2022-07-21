//
//  RecommandCollectionViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher

/*
 TableView -> CollectionView
 Row -> Item
 heightForRowAt -> FlowLayout (heightForItemAt이 없는 이유)
 */

class RecommandCollectionViewController: UICollectionViewController {

    var imageURL = "https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F109%2F2022%2F07%2F04%2F0004649879_004_20220704084603910.jpg&type=sc960_832"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정 (Estimate Size None으로 설정!)
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    // 아이템 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    // 아이템 디자인/데이터
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandCollectionViewCell", for: indexPath) as? RecommandCollectionViewCell else {
            return  UICollectionViewCell()
        }
        
        cell.posterImageView.backgroundColor = .orange
        
        let url = URL(string: imageURL)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    // 아이템을 선택했을 때 (토스트 띄우기)
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        view.makeToast("\(indexPath.item)번째 셀을 선택했습니다", duration: 3, position: .center)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
