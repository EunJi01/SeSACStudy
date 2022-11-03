//
//  LoginViewController.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    // MARK: 자동 로그인 구현 필요
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    let api = APIService()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "로그인"
        
        setConstraints()
        bind()
    }
    
    private func bind() {
        loginButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                guard let email = vc.emailTextField.text else { return }
                guard let password = vc.passwordTextField.text else { return }
                vc.requestLogin(email: email, password: password)
            }
            .disposed(by: disposeBag)
    }

    private func requestLogin(email: String, password: String) {
        api.login(email: email, password: password) { [weak self] result in
            print(result)
            guard result == true else { return }
            self?.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
    private func setConstraints() {
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