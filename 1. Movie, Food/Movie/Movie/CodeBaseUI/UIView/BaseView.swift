//
//  BaseView.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    func setConstraints() {}
}
