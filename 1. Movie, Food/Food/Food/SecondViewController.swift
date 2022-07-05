//
//  SecondViewController.swift
//  Food
//
//  Created by 황은지 on 2022/07/05.
//

import UIKit

class SecondViewController: UIViewController {

    // 아웃렛 변수
    @IBOutlet weak var mainBannerImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    
    // 뷰컨트롤러 생명주기 종류 중 하나
    // 사용자에게 화면이 보이기 직전에 실행되는 코드(보이고 나서 바뀌면 웃기니까...)
    // option command < >
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainBannerImageView.image = UIImage(named: "banner3")
        mainBannerImageView.layer.cornerRadius = 70
        mainBannerImageView.layer.borderWidth = 5
        mainBannerImageView.layer.borderColor = UIColor.blue.cgColor
        
        nameLable.text = "홍길동"
        nameLable.backgroundColor = .lightGray
        nameLable.textColor = .red
        nameLable.font = .boldSystemFont(ofSize: 30)
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        
        mainBannerImageView.image = UIImage(named: "banner\(Int.random(in: 1...3))")
        
    }
    
}
