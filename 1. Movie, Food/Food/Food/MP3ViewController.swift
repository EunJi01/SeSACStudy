//
//  MP3ViewController.swift
//  Food
//
//  Created by 황은지 on 2022/07/10.
//

import UIKit

class MP3ViewController: UIViewController {

    @IBOutlet weak var similarSongButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        similarSongButton.layer.borderWidth = 1
        similarSongButton.layer.borderColor = UIColor.white.cgColor
        similarSongButton.layer.cornerRadius = 5
    }
}
