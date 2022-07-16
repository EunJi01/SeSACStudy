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
        
        let emailFailAlert = UIAlertController(title: "회원가입 실패", message: "이메일은 필수 입력 사항입니다", preferredStyle: .alert)
        let passwordFailAlert = UIAlertController(title: "회원가입 실패", message: "비밀번호는 6자리 이상 입력헤주세요", preferredStyle: .alert)
        let recommendedCodeAlert = UIAlertController(title: "회원가입 실패", message: "쿠폰번호는 숫자만 입력 가능합니다", preferredStyle: .alert)
        let successAlert = UIAlertController(title: "회원가입 성공!", message: "잠시 후 메인 화면으로 이동합니다", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: nil)
        
        let alertControllerList = [emailFailAlert, passwordFailAlert, recommendedCodeAlert, successAlert]
        for i in alertControllerList {
            i.addAction(ok)
        }
        
        // 조건에 따른 Alert 띄우기
        if (emailTextField.text?.isEmpty)! {
            present(emailFailAlert, animated: true, completion: nil)
        } else if  (passwordTextField.text?.count)! < 6 {
            present(passwordFailAlert, animated: true, completion: nil)
        } else if (recommendedCodeTextField.text?.isEmpty == false) && Int(recommendedCodeTextField.text!) == nil {
            present(recommendedCodeAlert, animated: true, completion: nil)
        } else {
            present(successAlert, animated: true, completion: {  seguePosterViewController() })
        }
        
        // 화면 전환
        func seguePosterViewController() {
            sleep(2)
            
            performSegue(withIdentifier: "signUpVCSegue", sender: nil)
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
