//
//  WriteView.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit
import SnapKit

class WriteView: BaseView {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 1
        return view
    }()
    
    let titleTextField: BlackRadiusTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    let dateTextField: BlackRadiusTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    
    let contentTextView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let imageSearchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        view.contentMode = .scaleAspectFit
        view.contentHorizontalAlignment = .fill
        view.contentVerticalAlignment = .fill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [photoImageView, titleTextField, dateTextField, contentTextView, imageSearchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        imageSearchButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.bottom.equalTo(photoImageView).inset(12)
            make.trailing.equalTo(photoImageView).inset(12)
        }
    }
}
