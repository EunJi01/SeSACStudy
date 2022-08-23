//
//  BaseViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        setConstraints()
        tapGesture()
    }
    
    func tapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false // 중요!
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func configure() {}
    
    func setConstraints() {}
    
    func showAlertMessage(title: String, button: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
