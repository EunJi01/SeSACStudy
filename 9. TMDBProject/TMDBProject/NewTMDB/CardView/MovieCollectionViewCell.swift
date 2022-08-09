//
//  MovieCollectionViewCell.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/09.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        cardView.posterImageView.backgroundColor = .clear
        cardView.posterImageView.layer.cornerRadius = 10
    }
}
