//
//  BucketlistTableViewCell.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit

class BucketlistTableViewCell: UITableViewCell {

    static let identifire = "BucketlistTableViewCell"
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var bucketlistLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
