//
//  CardCollectionViewCell.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    // 변경되지 않는 UI (한번만 호출되기 때문)
    // awakeFromNib이 cellForItemAt 보다 먼저 실행된다
    override func awakeFromNib() {
        super.awakeFromNib()
        //print("CardCollectionViewCell", #function)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardView.contentLabel.text = nil
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .lightGray
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }
}
