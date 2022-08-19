//
//  CustomButton.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class WhiteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        whiteColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func whiteColor() {
        tintColor = .white
    }
    
//    func config(title: String, systemName image: String, imagePlacement: NSDirectionalRectEdge) {
//        var config = UIButton.Configuration.filled()
//        config.baseForegroundColor = .black
//        config.title = title
//        config.image = UIImage(systemName: image)
//        config.titlePadding = 10
//        config.imagePlacement = imagePlacement
//        config.attributedTitle?.font = .systemFont(ofSize: 14)
//        configuration = config
//    }
}
