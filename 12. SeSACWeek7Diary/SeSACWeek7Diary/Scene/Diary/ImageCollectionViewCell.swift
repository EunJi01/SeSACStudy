//
//  ImageCollectionViewCell.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/20.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let resultImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(resultImageView)
        resultImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self).inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                backgroundColor = .systemPink
            } else {
                backgroundColor = .white
            }
        }
    }
}
