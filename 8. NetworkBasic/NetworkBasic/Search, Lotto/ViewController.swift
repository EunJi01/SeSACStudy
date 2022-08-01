//
//  ViewController.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/07/28.
//

import Foundation
import UIKit

//class ViewController: UIViewController, ViewPresentableProtocol {
//
//    static let identifier: String = "ViewController"
//
//    var navigationTitleString: String = "대장님의 다마고치"
//
//    var backgroundColor: UIColor = .blue
//
//
//    func configureView() {
//        title = navigationTitleString
//        view.backgroundColor = backgroundColor
//        backgroundColor = .red
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        title = UserDefaultsHelper.standard.nickname
        
        UserDefaultsHelper.standard.age = 80
        print(UserDefaultsHelper.standard.age)
    }
}
