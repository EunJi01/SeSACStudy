//
//  LibraryCollectionViewCell.swift
//  Library
//
//  Created by 황은지 on 2022/07/20.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
 
    
    func configureCell(data: MovieStruct) {
        let colorList: [UIColor] = [.systemGray, .brown, .darkGray, .purple]
        self.backgroundColor = colorList.randomElement()!
        self.layer.cornerRadius = 15
        
        titleLabel.text = data.title
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        rateLabel.text = "\(data.rate)"
        rateLabel.textColor = .white
        rateLabel.font = .systemFont(ofSize: 12)
        
        titleImageView.image = UIImage(named: data.title)
    }
    
    // 셀 레이아웃
    func layoutCell(view: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing * 3)
    
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        view.collectionViewLayout = layout
    }
    
}
