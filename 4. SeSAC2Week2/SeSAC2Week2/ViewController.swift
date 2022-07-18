//
//  ViewController.swift
//  SeSAC2Week2
//
//  Created by 황은지 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emotionResetButton: UIButton!
    @IBOutlet var emotionButtonCollection: [UIButton]!
    
    var emotionDic: [String: Int] = [
        "행복해": 0,
        "사랑해": 0,
        "좋아해": 0,
        "당황해": 0,
        "속상해": 0,
        "우울해": 0,
        "심심해": 0,
        "꿀꿀해": 0,
        "슬퍼해": 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emotionCountLoad()
        
    }
    
    // 감정 버튼
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let result = keyExtraction(button: sender)
        
        emotionDic[result]! += 1

        UserDefaults.standard.set(emotionDic[result], forKey: "\(result)")
        sender.setTitle("\(String(describing: result)) \(String(describing: UserDefaults.standard.string(forKey: "\(result)")!))", for: .normal)
        
    }
    
    // 감정 초기화 버튼
    @IBAction func emotionResetButtonTapped(_ sender: UIButton) {
        for i in emotionButtonCollection {
            let result = keyExtraction(button: i)
            
            UserDefaults.standard.removeObject(forKey: result)
            emotionDic[result] = 0
            
            i.setTitle("\(String(describing: result)) \(String(emotionDic[result]!))", for: .normal)
        }
    }
    
    // viewDidLoad에 사용될 함수
    func emotionCountLoad() {
        for i in emotionButtonCollection {
            let result = keyExtraction(button: i)
            
            emotionDic[result] = UserDefaults.standard.integer(forKey: result)
            i.setTitle("\(String(describing: result)) \(emotionDic[result]!)", for: .normal)
            
        }
    }
    
    // 키 값(ex. 사랑해 좋아해 꿀꿀해) 3글자를 emotionButton의 Title에서 추출하는 함수
    func keyExtraction(button: UIButton) -> String {
        let key: String = button.currentTitle!
        let endIdx = key.index(key.startIndex, offsetBy: 2)
        
        return String(key[...endIdx])
    }
}

