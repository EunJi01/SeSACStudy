//
//  BaseViewController.swift
//  Movie
//
//  Created by 황은지 on 2022/08/19.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {}
    
    func showAlertMessage(title: String, button: String, handler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .cancel, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
