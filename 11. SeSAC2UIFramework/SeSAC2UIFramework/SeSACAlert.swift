//
//  SeSACAlert.swift
//  SeSAC2UIFramework
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    public func showSesacAlert(title: String, message: String, buttonTitle: String, buttonAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    open func testOpen() {}
    
    internal func testInternal() {}
    fileprivate func testFileprivate() {}
    private func testPrivate() {}
}
