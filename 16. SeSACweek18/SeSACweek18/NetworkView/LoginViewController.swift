//
//  LoginViewController.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import UIKit

class LoginViewController: ViewController {
    
    let api = APIService()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstraints()
    }
    
    func setConstraints() {
        emailTextField.textAlignment = .center
        passwordTextField.textAlignment = .center
        emailTextField.placeholder = "이메일을 입력해주세요"
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.systemBlue, for: .normal)
        
        [emailTextField, passwordTextField, loginButton].forEach {
            view.addSubview($0)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
}
