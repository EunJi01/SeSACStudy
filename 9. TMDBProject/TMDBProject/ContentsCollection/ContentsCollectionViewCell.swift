//
//  ContentsCollectionViewCell.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/03.
//

import UIKit

// 위치 : Cell
// 1. 프로토콜 만들기
protocol WebButtonDelegate {
    func webButtonTapped(index: Int)
}

class ContentsCollectionViewCell: UICollectionViewCell {

    static let identifier = "ContentsCollectionViewCell"
    
    @IBOutlet weak var contentsBackgroundView: UIView!
    @IBOutlet weak var contentsImageView: UIImageView!
    
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var viewMoreIconButton: UIButton!
    
    @IBOutlet weak var contentsReleaseLabel: UILabel!
    @IBOutlet weak var contentsGradeTextLabel: UILabel!
    @IBOutlet weak var contentsGradeScoreLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentsOverviewLabel: UILabel!
    @IBOutlet weak var contentsGenreLabel: UILabel!
    
    // 위치 : Cell
    // 2. 위임자 만들어주기
    var delegate: WebButtonDelegate?
    var index = 0
    
    // sender를 UIButton으로 하면 런타임 에러가 발생한다
    @IBAction func webButtonTapped(_ sender: Any) {
        self.delegate?.webButtonTapped(index: index)
    }
}
