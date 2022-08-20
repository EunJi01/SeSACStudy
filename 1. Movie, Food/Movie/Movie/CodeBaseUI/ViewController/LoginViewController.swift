//
//  LoginViewController.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class LoginViewController: BaseViewController {

    var mainView = LoginView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        let tapGustureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        mainView.addGestureRecognizer(tapGustureRecognizer)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
