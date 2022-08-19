//
//  CircleImageView.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class CircleImageView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        clipsToBounds = translatesAutoresizingMaskIntoConstraints
        contentMode = .scaleAspectFill
        layer.cornerRadius = 120 / 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
    }
}
