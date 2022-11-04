//
//  SignupViewModel.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel {
    let api = APIService()
    
    func requestSignup(selfVC: SignupViewController, userName: String, email: String, password: String) {
        api.signup(userName: userName, email: email, password: password) { [weak self] result in
            guard result == true else { return }
            guard let self = self else { return }
            
            self.api.login(email: email, password: password) { result in
                guard result == true else { return }
                let vc = ProfileViewController()
                selfVC.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
