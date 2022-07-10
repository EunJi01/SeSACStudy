//
//  KakaoViewController.swift
//  Food
//
//  Created by 황은지 on 2022/07/10.
//

import UIKit

class KakaoViewController: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileButton.layer.cornerRadius = 35
        print("제대로 되는거 맞냐")
        
        nameLabel.font = .boldSystemFont(ofSize: 20)
        
    }
}
