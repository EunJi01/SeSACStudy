//
//  MainTableViewCell.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // contentCollectionView도 delegate, datasource가 필요함!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MainTableViewCell", #function)
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "넷플릭스 인기 콘텐츠"
        titleLabel.backgroundColor = .clear
        
        contentCollectionView.backgroundColor = .clear
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
