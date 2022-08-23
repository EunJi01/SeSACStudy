//
//  HomeTableViewCell.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [photoImageView, titleLabel, dateLabel].forEach {
            addSubview($0)
        }
    }
    
    func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(8)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leadingMargin.equalTo(photoImageView.snp_trailingMargin).offset(28)
        }
        
//        dateLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(self.snp.centerY)
//            make.trailing.equalTo(self).inset(8)
//        }
    }
}
