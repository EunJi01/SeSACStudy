//
//  ViewController.swift
//  SeSAC2Week2
//
//  Created by 황은지 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emotionButtonCollection: [UIButton]!
    
    let emotionList: [String] = [ "행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "꿀꿀해", "슬퍼해"]
    var emotionCountList: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
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
        
    }
}

