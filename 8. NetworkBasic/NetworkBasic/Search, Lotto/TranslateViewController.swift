//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

// UIButton, UITextField -> Action 연결 가능
// UITextView, UISearchBar, UIPickerView -> Action 연결 불가능
// 왜? control을 상속받지 않았기 때문
// UIResponderChain -> resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "Menlo-Bold", size: 20)
        
        requestTranslateData(text: "")
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        guard let text = userInputTextView.text else { return }
        requestTranslateData(text: text)
    }
    
    func requestTranslateData(text: String) {
        let url = EndPoint.translateURL
        
        let parameter = ["source": "ko", "target": "jaaaa", "text": text]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.resultLabel.text = json["message"]["result"]["translatedText"].stringValue
                
//                let statusCode = response.self.response?.statusCode ?? 500
//
//                if statusCode == 200 {
//
//                } else {
//                    self.resultLabel.text = json["errorMessage"].stringValue
//                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 때. 커서가 시작될 때
    // 텍스트뷰 글자 : 플레이스 홀더랑 글자가 같으면 clear
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝났을 때. 커서가 없어지는 순간
    // 텍스트뷰 글자 : 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
