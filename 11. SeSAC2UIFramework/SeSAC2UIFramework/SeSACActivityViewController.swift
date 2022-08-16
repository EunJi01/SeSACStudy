//
//  SeSACActivityViewController.swift
//  SeSAC2UIFramework
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit

extension UIViewController {
    
    //UIActivityViewController
    public func sesacShowActivityViewController(shareImage: UIImage, shareURL: String, shareText: String) {
        
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText], applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail, .assignToContact]
        self.present(viewController, animated: true)
    }
}
