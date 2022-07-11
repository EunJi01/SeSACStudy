//
//  ViewController.swift
//  SeSAC2Week2
//
//  Created by 황은지 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
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
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let key: String = sender.titleLabel!.text!
        
        let endIdx = key.index(key.startIndex, offsetBy: 2)
        
        let result = String(key[...endIdx])
        print(result)
        
        emotionDic[result]! += 1
        print(emotionDic[result]!)
        
        sender.setTitle("\(String(describing: result)) \(emotionDic[result]!)", for: .normal)
        // 이렇게까지 비효율적으로 코드 쓴 사람은 나밖에 없을듯
    }
}

