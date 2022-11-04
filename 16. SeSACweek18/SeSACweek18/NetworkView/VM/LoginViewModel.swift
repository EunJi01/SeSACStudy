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
    
    func requestLogin(selfVC: LoginViewController, email: String, password: String) {
        api.login(email: email, password: password) { result in
            guard result == true else { return }
            let vc = ProfileViewController()
            selfVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
