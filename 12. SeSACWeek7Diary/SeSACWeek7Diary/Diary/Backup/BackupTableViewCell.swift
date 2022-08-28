//
//  BackupTableViewCell.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/27.
//

import UIKit
import SnapKit
import SeSAC2UIFramework

class BackupTableViewCell: UITableViewCell {
    
    let fileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "folder")
        view.tintColor = .black
        return view
    }()
    
    let fileNameLabel: UILabel = {
        let view = UILabel()
        view.text = "테스트"
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
        [fileImageView, fileNameLabel].forEach {
            addSubview($0)
        }
    }
    
    func setConstraints() {
        fileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(28)
            make.leadingMargin.equalTo(self).offset(20)
        }
        
        fileNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leadingMargin.equalTo(fileImageView.snp.trailing).offset(36)
        }
    }
}
