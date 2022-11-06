//
//  ProfileViewModel.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel2 {
    let api = APIService()
    let disposeBag = DisposeBag()
    
    struct Input {
        let logoutButtonTap: Signal<Void>
    }
    
    struct Output {
        let profile: Signal<User>
        let logout: Signal<Void>
    }
    
    let profileRelay = PublishRelay<User>()
    let logoutRelay = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        input.logoutButtonTap
            .emit { _ in
                UserDefaults.standard.removeObject(forKey: "token")
            }
            .disposed(by: disposeBag)
        
        return Output(profile: profileRelay.asSignal(), logout: logoutRelay.asSignal())
    }

    func imageFormat(url: String) -> Data {
        guard let url = URL(string: url) else { return Data() }
        guard let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
    
    func requestProfile() {
        api.profile { user, error in
            guard let user = user else { return }
            self.profileRelay.accept(user)
        }
    }
}
