//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/07/19.
//

import UIKit

extension UIViewController {
    
    func setBackgroundColor() {
        
        view.backgroundColor = .orange
        
    }
    
    func showAlert(alrtTitle: String, alertMessage: String) {
        
        let alert = UIAlertController(title: alrtTitle, message: alertMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
        
    }
    
}
