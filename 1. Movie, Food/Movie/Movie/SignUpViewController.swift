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
        
        designTitleLabel()
        designSignUpButton()
        designtextField()
                  
        additionalInformationSwitch.onTintColor = .systemPink
        additionalInformationSwitch.thumbTintColor = .white
        
        subLabel.text = "추가 정보 입력"
        
    }
    
    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func SignUpButtonTapped(_ sender: UIButton) {
        
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.count)! < 5 {
            signUpButton.setTitle("이메일 또는 비밀번호를 다시 입력해주세요", for: .highlighted)
            // 회원가입에 실패했을 때 위의 highlighted 메세지가 바로 나오지 않는 현상 있음. 아래의 print는 정상 출력됨...ㅠ
            print("회원가입 실패")
        } else if (recommendedCodeTextField.text?.isEmpty == false) && Int(recommendedCodeTextField.text!) == nil {
            signUpButton.setTitle("쿠폰번호는 숫자만 입력 가능합니다", for: .highlighted)
        } else {
            signUpButton.setTitle("회원가입 완료!", for: .normal)
        }
        
    }
    
    func designtextField() {
        let textFieldPlaceholderList = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
        
        for (textField, text) in zip(textFieldList, textFieldPlaceholderList) {
            
            textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField.layer.cornerRadius = 10
            textField.backgroundColor = .darkGray
            textField.textAlignment = .center
            
        }
        
        emailTextField.keyboardType = .emailAddress
        recommendedCodeTextField.keyboardType = .numberPad
        passwordTextField.isSecureTextEntry = true
        
    }
    
    func designTitleLabel() {
        titleLable.text = "JACKFLIX"
        titleLable.textColor = .systemPink
        titleLable.textAlignment = .center
        titleLable.font = .systemFont(ofSize: 10)
        titleLable.font = .boldSystemFont(ofSize: 40)
    }
    
    func designSignUpButton() {
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.tintColor = .black
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    }
}
