//
//  MainViewController.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class MainViewController: BaseViewController {

    var mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    @objc func playButtonTapped() {
        showAlertMessage(title: "회원가입을 먼저 진행해주세요", button: "확인", handler: { _ in self.present(LoginViewController(), animated: true) })
    }
}
