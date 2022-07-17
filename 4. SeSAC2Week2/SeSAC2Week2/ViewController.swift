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
        
        emotionCountLoad()
        
//        emotionButtonCollection[0].setTitle(setUserNickname(), for: .normal)
//
//        view.backgroundColor = example().0
//        emotionButtonCollection[1].setTitle(example().1, for: .normal)
//        emotionButtonCollection[1].setImage(UIImage(named: example().2), for: .normal)
    }
    

    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        let key: String = sender.titleLabel!.text!
        let endIdx = key.index(key.startIndex, offsetBy: 2)
        let result = String(key[...endIdx])
        
        emotionDic[result]! += 1
//        print(emotionDic[result]!)

        UserDefaults.standard.set(emotionDic[result], forKey: "\(result)")
        
        sender.setTitle("\(String(describing: result)) \(String(describing: UserDefaults.standard.string(forKey: "\(result)")!))", for: .normal)
        
        print(result, UserDefaults.standard.string(forKey: "\(result)")!)
        
//        showAlertController()
    }
    
    func emotionCountLoad() {
        for i in emotionButtonCollection {
            let key: String = i.titleLabel!.text!
            let endIdx = key.index(key.startIndex, offsetBy: 2)
            let result = String(key[...endIdx])
            
            emotionDic[result] = UserDefaults.standard.integer(forKey: result)
            
            if UserDefaults.standard.string(forKey: "\(result)") == nil {
                i.setTitle("\(String(describing: result)) \(String(describing: 0))", for: .normal)
            } else {
                i.setTitle("\(String(describing: result)) \(String(describing: UserDefaults.standard.string(forKey: "\(result)")!))", for: .normal)
            }
        }
        print(emotionDic)
    }
    
    
    // 배경색, 레이블, 이미지
//    func example() -> (UIColor, String, String){
//
//        let color: [UIColor] = [.darkGray, .blue, .green]
//        let image: [String] = ["sesac_slime6", "sesac_slime7", "sesac_slime8", "sesac_slime5"]
//
//        return (color.randomElement()!, "고래밥", image.randomElement()!)
//
//    }
    
    
//    func setUserNickname() -> String {
//        let nickname = ["고래밥", "칙촉", "격투가"]
//        let select = nickname.randomElement()!
//
//        return "\(select)이당"
//    }
    
//    func showAlertController() {
//
//        // 1. 흰 바탕: UIAlertController
//        let alert = UIAlertController(title: "타이틀", message: "여기는 메세지가 들어갑니다", preferredStyle: .alert)
//
//        // 2. 버튼
//        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
//        let cancel = UIAlertAction(title: "취소버튼입니다", style: .cancel, handler: nil)
//        let web = UIAlertAction(title: "새 창으로 열기", style: .destructive, handler: nil)
//        let copy = UIAlertAction(title: "복사하기", style: .destructive, handler: nil)
//
//        // 3. 1+2(합치기)
//        alert.addAction(copy)
//        alert.addAction(cancel)
//        alert.addAction(web)
//        alert.addAction(ok)
//
//        // 4. 창 띄우기
//        present(alert, animated: true, completion: nil)
//    }
    
}

