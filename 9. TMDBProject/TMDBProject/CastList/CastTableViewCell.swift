//
//  CastTableViewCell.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/04.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    static let identifier = "CastTableViewCell"
    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castPartLabel: UILabel!
}
