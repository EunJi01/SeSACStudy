//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
