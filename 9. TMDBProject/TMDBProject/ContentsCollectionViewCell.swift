//
//  ContentsCollectionViewCell.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/03.
//

import UIKit

class ContentsCollectionViewCell: UICollectionViewCell {

    static let identifier = "ContentsCollectionViewCell"
    
    @IBOutlet weak var contentsBackgroundView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentsImageView: UIImageView!
    
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var viewMoreIconButton: UIButton!
    
    @IBOutlet weak var contentsReleaseLabel: UILabel!
    @IBOutlet weak var contentsGradeTextLabel: UILabel!
    @IBOutlet weak var contentsGradeScoreLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentsOverviewLabel: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
}
