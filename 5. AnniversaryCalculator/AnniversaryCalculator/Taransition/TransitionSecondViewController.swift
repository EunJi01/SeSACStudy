//
//  TransitionSecondViewController.swift
//  AnniversaryCalculator
//
//  Created by 황은지 on 2022/07/15.
//

import UIKit

// 열거형을 활용해서 오타 방지/더 쉽게 코드 작성 가능
enum UserDefaultsKey: String {
    case happyEmotion
}

class TransitionSecondViewController: UIViewController {
    
    @IBOutlet weak var EmotionUpButton: UIButton!
    @IBOutlet weak var EmotionCountLabel: UILabel!
    
    @IBOutlet weak var mottoTextView: UITextView!
    /*
     1. 앱 켜면 데이터를 가지고 와서 텍스트 뷰에 보여주어야 함.
     2. 바뀐 데이터를 저장해주어야 함.
     => UserDefault
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TransitionSecondViewController", #function)
        
        EmotionCountLabel.text = "\(UserDefaults.standard.integer(forKey: UserDefaultsKey.happyEmotion.rawValue))"
        
        if UserDefaults.standard.string(forKey: "nickname") != nil {
            // 가져오기
            mottoTextView.text = UserDefaults.standard.string(forKey: "nickname")
        } else {
            //데이터가 없는 경우에 사용할 문구
            mottoTextView.text = "아무것도 읎지렁"
        }
        
//        반환값에 따라 체크해야할 요소가 달라질 수 있다.
//        print(UserDefaults.standard.integer(forKey: "age"))
//        print(UserDefaults.standard.bool(forKey: "inapp"))
        
        
        UserDefaults.standard.string(forKey: "emotion")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("TransitionSecondViewController", #function)
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set(mottoTextView.text, forKey: "nickname")
        print("저장되었습니다!")
        
    }
    @IBAction func EmotionUpButtonTapped(_ sender: UIButton) {
        
        // 기존 데이터 값 가져오기
        let currntValut = UserDefaults.standard.integer(forKey: UserDefaultsKey.happyEmotion.rawValue)
        
        // 감정 + 1
        let updateValue = currntValut + 1
        
        // 새로운 값 저장
        UserDefaults.standard.set(updateValue, forKey: UserDefaultsKey.happyEmotion.rawValue)
        
        // 레이블에 새로운 내용 보여주기
        EmotionCountLabel.text = "\(UserDefaults.standard.integer(forKey: UserDefaultsKey.happyEmotion.rawValue))"
    }
}
