//
//  BookSearchViewController.swift
//  Library
//
//  Created by 황은지 on 2022/07/21.
//

import UIKit

class BookSearchViewController: UIViewController {

    static let identifier = "BookSearchViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNavigationItem()
        
    }
    
    // 네비게이션 바 아이템
    func addNavigationItem() {
        navigationItem.title = "검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    // 백 버튼
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
}
