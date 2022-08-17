//
//  KakaoLayoutViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/17.
//

import UIKit
import SnapKit

class KakaoLayoutViewController: UIViewController {

    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let presentButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "shippingbox.circle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let qrCodeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "gearshape.circle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let profileButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "person.fill"), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .black
        view.layer.cornerRadius = 40
        return view
    }()
    
    let chatButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "message.fill"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let profileEditButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let kakaostoryButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "circle.square"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let chatLabel: UILabel = {
        let view = UILabel()
        view.text = "나와의 채팅"
        view.textColor = .white
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let profileEditLabel: UILabel = {
        let view = UILabel()
        view.text = "프로필 편집"
        view.textColor = .white
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let kakaostoryLabel: UILabel = {
        let view = UILabel()
        view.text = "카카오스토리"
        view.textColor = .white
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Lia"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let profileMessageLabel: UILabel = {
        let view = UILabel()
        view.text = "코딩 너무 재미따~~"
        view.textColor = .white
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        
        configureButtonUI()
        configureLabel()
    }
    
    func configureButtonUI() {
        [cancelButton, presentButton, qrCodeButton, settingButton, chatButton, profileEditButton, kakaostoryButton, profileButton].forEach {
            view.addSubview($0)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view).offset(-16)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        qrCodeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailingMargin.equalTo(settingButton).offset(-36)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        presentButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailingMargin.equalTo(qrCodeButton).offset(-36)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.centerX.equalTo(view.center)
        }
        
        chatButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.leadingMargin.equalTo(60)
        }
        
        kakaostoryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.trailingMargin.equalTo(-60)
        }
        
        profileButton.snp.makeConstraints { make in
            make.topMargin.equalTo(profileEditButton).offset(-200)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.centerX.equalTo(view.center)
        }
    }
    
    func configureLabel() {
        [chatLabel, profileEditLabel, kakaostoryLabel, nameLabel, profileMessageLabel].forEach {
            view.addSubview($0)
        }
        
        profileMessageLabel.snp.makeConstraints { make in
            make.bottomMargin.equalTo(profileEditButton).offset(-100)
            make.centerX.equalTo(view.center)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottomMargin.equalTo(profileMessageLabel).offset(-28)
            make.centerX.equalTo(view.center)
        }
        
        profileEditLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileEditButton).offset(8)
            make.centerX.equalTo(view.center)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.bottom.equalTo(chatButton).offset(8)
            make.centerX.equalTo(chatButton.snp.centerX)
        }
        
        kakaostoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(kakaostoryButton).offset(8)
            make.centerX.equalTo(kakaostoryButton.snp.centerX)
        }
    }
}
