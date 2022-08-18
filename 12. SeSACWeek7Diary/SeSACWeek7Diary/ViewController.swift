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
        
        configure()
        
        nameButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
    }
    
    @objc func nameButtonTapped() {
        let vc = ProfileViewController()
        
        vc.saveButtonActionHandler = {
            self.nameButton.setTitle(vc.nameTextField.text, for: .normal)
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
