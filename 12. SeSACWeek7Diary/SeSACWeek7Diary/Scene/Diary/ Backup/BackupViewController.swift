//
//  BackupViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/24.
//

import UIKit

class BackupViewController: BaseViewController {
    
    let mainView = BackupView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
