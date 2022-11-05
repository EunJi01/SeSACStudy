//
//  LoginViewModel.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let api = APIService()
    
    struct Input {
        let loginButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let loginButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(loginButtonTap: input.loginButtonTap)
    }
    
    func requestLogin(selfVC: LoginViewController, email: String, password: String) {
        api.login(email: email, password: password) { result in
            guard result == true else { return }
            let vc = ProfileViewController()
            selfVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
