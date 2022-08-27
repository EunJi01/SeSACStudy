//
//  ViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit
import SeSAC2UIFramework
import SnapKit

class ViewController: UIViewController {
    
    let nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure()
        
        //nameButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(notification:)), name: NSNotification.Name("saveButtonNotification"), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func saveButtonNotificationObserver(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameButton.setTitle(name, for: .normal)
        }
    }
    
    @objc func nameButtonTapped() {
//        NotificationCenter.default.post(name: NSNotification.Name("TEST"), object: nil, userInfo: ["name": "\(Int.random(in: 1...100))", "vlaue": 123456])
        
        let vc = ProfileViewController()
        
        vc.saveButtonActionHandler = { name in
            self.nameButton.setTitle(name, for: .normal)
        }
        
        present(vc, animated: true)
    }
    
    func configure() {
        view.addSubview(nameButton)
        
        nameButton.snp.remakeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
    }
}
