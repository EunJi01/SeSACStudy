//
//  ViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit
import SeSAC2UIFramework

class ViewController: UIViewController {
    
    var name = "고래밥" // 명시하지 않으면 자동으로 internal로 제한됨
    private var age = 22

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = CodeSnap2ViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
        testOpen()
        
//        showSesacAlert(title: "테스트 얼럿", message: "테스트 메세지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//        }
        
//        let image = UIImage(systemName: "star.fill")!
//        let shareURL = "https://www.apple.com"
//        let text = "WWDC What's New!!!"
//        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        
        //OpenWebView.presentWebViewController(self, url: "https://www.naver.com", transitionStyle: .present)
    }
}
