//
//  SignupViewController.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa

final class SignupViewController: UIViewController {
    
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signupButton = UIButton()
    let loginButton = UIBarButtonItem(title: "로그인", style: .plain, target: SignupViewController.self, action: nil)
    
    let api = APIService()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "회원가입"
        navigationItem.rightBarButtonItem = loginButton
        
        setConstraints()
        bind()
    }
    
    private func bind() {
        signupButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                guard let userName = vc.nameTextField.text else { return }
                guard let email = vc.emailTextField.text else { return }
                guard let password = vc.passwordTextField.text, password.count > 7 else { return }
                vc.requestSignup(userName: userName, email: email, password: password)
            }
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func requestSignup(userName: String, email: String, password: String) {
        api.signup(userName: userName, email: email, password: password) { result in
            guard result == true else { return }

            // MARK: 회원가입 후 바로 로그인 -> 프로필로 이동 구현 필요
            self.api.login(email: email, password: password) { [weak self] result in
                guard result == true else { return }
                self?.navigationController?.pushViewController(ProfileViewController(), animated: true)
            }
        }
    }
    
    private func setConstraints() {
        nameTextField.textAlignment = .center
        emailTextField.textAlignment = .center
        passwordTextField.textAlignment = .center
        nameTextField.placeholder = "이름을 입력해주세요"
        emailTextField.placeholder = "이메일을 입력해주세요"
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(.systemBlue, for: .normal)
        
        [nameTextField, emailTextField, passwordTextField, signupButton].forEach {
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(200)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
}
