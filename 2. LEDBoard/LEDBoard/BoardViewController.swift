//
//  BoardViewController.swift
//  LEDBoard
//
//  Created by 황은지 on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var resultLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.placeholder = "내용을 작성해주세요"
        userTextField.text = "안녕하세요"
        userTextField.keyboardType = .emailAddress

        sendButton.setTitle("전송", for: .normal)
        sendButton.setTitle("빨리보내!", for: .highlighted)
        sendButton.backgroundColor = .yellow
        sendButton.layer.cornerRadius = 8
        sendButton.layer.borderWidth = 3
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitleColor(.blue, for: .highlighted)
        
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
        resultLable.text = userTextField.text
        
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
}
