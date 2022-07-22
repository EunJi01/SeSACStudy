//
//  BookDetailViewController.swift
//  Library
//
//  Created by 황은지 on 2022/07/21.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    static let identifier = "BookDetailViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNavigationItem()
        
    }
    
    // 네비게이션 아이템
    func addNavigationItem() {
        navigationItem.title = "상세 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    // 백 버튼
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 웹 화면으로 이동
    @IBAction func pushWebButtonTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: WebViewController.identifire) as? WebViewController else {
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
