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
    let disposeBag = DisposeBag()
    
    struct Input {
        let loginButtonTap: Signal<(String, String)>
    }
    
    struct Output {
        let pushProfileVC: Signal<Void>
    }
    
    let pushProfileVCRelay = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        input.loginButtonTap
            .emit { [weak self] email, password in
                self?.requestLogin(email: email, password: password)
            }
            .disposed(by: disposeBag)
        
        return Output(pushProfileVC: pushProfileVCRelay.asSignal())
    }
    
    func requestLogin(email: String, password: String) {
        api.login(email: email, password: password) { [weak self] result in
            guard result == true else { return }
            self?.pushProfileVCRelay.accept(())
        }
    }
}
