//
//  LoginViewController.swift
//  SeSACWeek9
//
//  Created by 황은지 on 2022/09/01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.name.bind { text in
            // 더 많은 기능이 들어갈 때 필요한 코드! 지금 당장은 차이가 없음
            self.nameTextField.text = text
        }

        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .red : .lightGray
        }
    }
    
    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        viewModel.name.value = nameTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        viewModel.signIn {
            // 로그인, 화면 전환
        }
    }
}
