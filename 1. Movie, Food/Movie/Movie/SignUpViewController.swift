//
//  SignUpViewController.swift
//  Movie
//
//  Created by 황은지 on 2022/07/06.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var additionalInformationSwitch: UISwitch!
    
    @IBOutlet var textFieldList: [UITextField]!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var recommendedCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLable.text = "JACKFLIX"
        titleLable.textColor = .systemPink
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: 10)
        titleLable.font = .boldSystemFont(ofSize: 40)
        
        signUpButton.setTitle("회원가입", for: .normal)
//        signUpButton.setTitle("가입 들어갑니다 슝슝~", for: .highlighted)
        signUpButton.tintColor = .black
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
//        emailTextField.placeholder = "이메일 주소 또는 전화번호"
//        passwordTextField.placeholder = "비밀번호"
//        nicknameTextField.placeholder = "닉네임"
//        locationTextField.placeholder = "위치"
//        recommendedCodeTextField.placeholder = "추천 코드 입력"
        
        emailTextField.keyboardType = .emailAddress
        recommendedCodeTextField.keyboardType = .numberPad
        
        let textFieldPlaceholderList = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
        
        for (textField, text) in zip(textFieldList, textFieldPlaceholderList) {
            
            textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField.layer.cornerRadius = 10
            textField.backgroundColor = .darkGray
            textField.textAlignment = .center
            
        }
        
        additionalInformationSwitch.onTintColor = .systemPink
        additionalInformationSwitch.thumbTintColor = .white
        
        subLabel.text = "추가 정보 입력"
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
        
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.count)! < 5 {
            signUpButton.setTitle("회원가입 실패...ㅠㅠ", for: .highlighted)
        } else {
            signUpButton.setTitle("회원가입 완료!", for: .normal)
        }
        
    }
}
