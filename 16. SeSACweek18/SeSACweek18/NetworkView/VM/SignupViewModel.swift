//
//  SignupViewModel.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

final class SignupViewModel {
    let api = APIService()
    let disposeBag = DisposeBag()
    
    struct Input {
        let signupButtonTap: Signal<(String, String, String)>
        let loginButtonTap: Signal<Void>
    }
    
    struct Output {
        let pushLoginVC: Signal<Void>
        let pushProfileVC: Signal<Void>
    }
    
    let pushLoginVCRelay = PublishRelay<Void>()
    let pushProfileVCRelay = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        input.signupButtonTap
            .emit { [weak self] name, email, password in
                guard !(name.isEmpty && email.isEmpty && password.isEmpty) else { return }
                guard password.count > 7 else { return }
                self?.requestSignup(userName: name, email: email, password: password)
            }
            .disposed(by: disposeBag)
        
        return Output(
            pushLoginVC: pushLoginVCRelay.asSignal(),
            pushProfileVC: pushProfileVCRelay.asSignal()
        )
    }
    
    func requestSignup(userName: String, email: String, password: String) {
        api.signup(userName: userName, email: email, password: password) { [weak self] result in
            guard result == true else { return }
            guard let vm = self else { return }
            
            vm.api.login(email: email, password: password) { result in
                guard result == true else { return }
                vm.pushProfileVCRelay.accept(())
            }
        }
    }
}
