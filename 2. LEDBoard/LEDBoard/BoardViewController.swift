//
//  BoardViewController.swift
//  LEDBoard
//
//  Created by 황은지 on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.delegate = self
        }
    }
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var resultLable: UILabel!
    @IBOutlet var buttonList: [UIButton]!
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // userTextField.delegate = self

        designTextField()
        designButton(sendButton, buttonTitle: "전송", HightlightedTitle: "빨리!!", bgColor: .yellow)
        designButton(textColorButton, buttonTitle: "컬러", HightlightedTitle: "바뀐다!", bgColor: .white)
    }
    
    func designTextField() {
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.text = "안녕하세요"
        userTextField.keyboardType = .emailAddress
        userTextField.returnKeyType = .done
    }
    
    // buttonOutletVariableName: 외부 매개변수, Argument Label -> 생략 가능
    // buttonName: 내부 매개변수, Parameter Name
    // _ : 와일드 카드 식별자
    func designButton(_ buttonName: UIButton, buttonTitle: String, HightlightedTitle: String, bgColor: UIColor) {
        buttonName.setTitle(buttonTitle, for: .normal)
        buttonName.setTitle(HightlightedTitle, for: .highlighted)
        buttonName.backgroundColor = bgColor
        buttonName.layer.cornerRadius = 8
        buttonName.layer.borderWidth = 3
        buttonName.layer.borderColor = UIColor.black.cgColor
        buttonName.setTitleColor(.red, for: .normal)
        buttonName.setTitleColor(.blue, for: .highlighted)
    }
    
    func studyOutletCollection() {
        // 1. 반복문
        let buttonArray: [UIButton] = [sendButton, textColorButton]
        
        for item in buttonArray {
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
        
        // 2. 아울렛 컬렉션
        for item in buttonList {
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
        resultLable.text = userTextField.text
        
    }

    var isHidden = false
    
    @IBAction func guestureAndButtonTapped(_ sender: Any) {
        
        // 키보드 내리기
        view.endEditing(true)
        
        // 상단 view 숨기기
        isHidden = !isHidden
        
        if isHidden == true {
            subView.isHidden = true
        } else {
            subView.isHidden = false
            
        }
    }
    
//    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
//    }
    
}

extension BoardViewController: UITextFieldDelegate {
    // 리턴키 델리게이트 처리
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //텍스트필드 비활성화
        //view.endEditing(true)
        textField.resignFirstResponder()
        sendButtonClicked(sendButton)
        return true
    }
}
