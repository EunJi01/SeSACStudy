//
//  BeerListTableViewCell.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/02.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {
    
    static let identifier = "BeerListTableViewCell"

    @IBOutlet weak var beerIdLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
}
