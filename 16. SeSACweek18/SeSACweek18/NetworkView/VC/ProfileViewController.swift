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
        bind()
    }
    
    private func bind() {
        let input = ProfileViewModel2.Input(logoutButtonTap: logoutButton.rx.tap.asSignal())
        let output = vm.transform(input: input)
        
        // MARK: 잭님 헬프... requestProfile는 UI 관련 코드가 아닌데 ViewController에 써도 될지? profileRelay를 직접 bind 해도 되는지???
        vm.requestProfile()
        vm.profileRelay
            .bind { [weak self] user in
                self?.emailLabel.text = user.email
                self?.nameLabel.text = user.username
                
                DispatchQueue.global().async {
                    guard let data = self?.vm.imageFormat(url: user.photo) else { return }

                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        output.logout
            .emit(onNext: { [weak self] _ in
                self?.logout()
            })
            .disposed(by: disposeBag)
    }
    
    private func logout() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = SignupViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
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
