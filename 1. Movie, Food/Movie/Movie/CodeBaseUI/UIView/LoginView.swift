//
//  LoginView.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class LoginView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "JACKFLIX"
        view.textColor = .red
        view.font = .boldSystemFont(ofSize: 40)
        return view
    }()
    
    let emailTextField: UITextField = {
        let view = UserTextField()
        view.placeholder = "이메일 주소 또는 전화번호"
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UserTextField()
        view.placeholder = "비밀번호"
        view.keyboardType = .numberPad
        view.isSecureTextEntry = true
        return view
    }()
    
    let nicknameTextField: UITextField = {
        let view = UserTextField()
        view.placeholder = "닉네임"
        return view
    }()
    
    let locationTextField: UITextField = {
        let view = UserTextField()
        view.placeholder = "위치"
        return view
    }()
    
    let recommendCodeTextField: UITextField = {
        let view = UserTextField()
        view.placeholder = "추천코드"
        return view
    }()
    
    let signUpButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("회원가입", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 17)
        view.tintColor = .black
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 5
        return view
    }()
    
    let addDataLabel: UILabel = {
        let view = UILabel()
        view.text = "추가 정보 입력"
        view.textColor = .lightGray
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let addDataSwitch: UISwitch = {
        let view = UISwitch()
        view.onTintColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [titleLabel, emailTextField, passwordTextField, nicknameTextField, locationTextField, recommendCodeTextField, signUpButton, addDataLabel, addDataSwitch].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(70)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp_bottomMargin).offset(150)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
            make.height.equalTo(36)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(emailTextField.snp_bottomMargin).offset(32)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(passwordTextField.snp_bottomMargin).offset(32)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(nicknameTextField.snp_bottomMargin).offset(32)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height)
        }
        
        recommendCodeTextField.snp.makeConstraints { make in
            make.topMargin.equalTo(locationTextField.snp_bottomMargin).offset(32)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.topMargin.equalTo(recommendCodeTextField.snp_bottomMargin).offset(32)
            make.leading.equalTo(emailTextField.snp.leading)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(48)
        }
        
        addDataLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(signUpButton.snp_bottomMargin).offset(40)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        addDataSwitch.snp.makeConstraints { make in
            make.topMargin.equalTo(signUpButton.snp_bottomMargin).offset(40)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
    }
}
