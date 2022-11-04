//
//  ProfileViewController.swift
//  SeSACweek18
//
//  Created by 황은지 on 2022/11/02.
//

import UIKit
import RxCocoa
import RxSwift

final class ProfileViewController: UIViewController {
    
    let imageView = UIImageView()
    let emailLabel = UILabel()
    let nameLabel = UILabel()
    let logoutButton = UIBarButtonItem(title: "로그아웃", style: .plain, target: ProfileViewController.self, action: nil)
    
    let vm = ProfileViewModel2()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "프로필"
        navigationItem.rightBarButtonItem = logoutButton
        
        setConstraints()
        requestProfile()
        bing()
    }
    
    private func bing() {
        logoutButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.logout()
            }
            .disposed(by: disposeBag)
    }
    
    private func logout() {
        UserDefaults.standard.removeObject(forKey: "token")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = SignupViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    private func requestProfile() {
        vm.api.profile { [weak self] user, error in
            guard let user = user else { return }
            self?.emailLabel.text = user.email
            self?.nameLabel.text = user.username
            
            DispatchQueue.global().async {
                guard let data = self?.vm.imageFormat(url: user.photo) else { return }

                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func setConstraints() {
        [imageView, emailLabel, nameLabel].forEach {
            view.addSubview($0)
        }
        
        nameLabel.font = .boldSystemFont(ofSize: 30)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.top).offset(-20)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
}
