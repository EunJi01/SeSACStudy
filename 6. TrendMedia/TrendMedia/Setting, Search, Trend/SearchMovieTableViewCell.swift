//
//  SearchMovieTableViewCell.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/20.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    
    func configureCell(data: MovieStruct) {
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.text = data.title
        releaseLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        overviewLabel.text = data.overview
        overviewLabel.numberOfLines = 0
        
    }
}
