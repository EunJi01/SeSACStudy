//
//  SettingViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/26.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
