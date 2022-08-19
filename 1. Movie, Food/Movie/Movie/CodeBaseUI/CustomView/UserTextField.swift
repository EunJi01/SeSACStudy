//
//  UserTextField.swift
//  Movie
//
//  Created by 황은지 on 2022/08/20.
//

import UIKit

class UserTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .systemGray2
        layer.cornerRadius = 5
        textAlignment = .center
        font = .systemFont(ofSize: 14)
    }
}
