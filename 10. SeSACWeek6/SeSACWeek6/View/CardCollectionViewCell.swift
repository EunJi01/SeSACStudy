//
//  CardCollectionViewCell.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    // 변경되지 않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .lightGray
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }
}
