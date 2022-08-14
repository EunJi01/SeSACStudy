//
//  UILabel + Extension.swift
//  SeSACWeek6
//
//  Created by 황은지 on 2022/08/13.
//

import UIKit

extension UILabel {
    func customDesign() {
        self.text = ""
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.font = .systemFont(ofSize: 15)
        self.backgroundColor = .white
    }
}

extension UIImageView {
    func customDesign() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
}

extension UIButton {
    func reloadDesign() {
        var config = UIButton.Configuration.filled()
        config.title = "현재 위치 새로고침"
        config.image = UIImage(systemName: "arrow.clockwise")
        config.imagePadding = CGFloat(20)
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .clear

        self.configuration = config
    }
}
