//
//  ViewController.swift
//  Movie
//
//  Created by 황은지 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var thumbnail1: UIImageView!
    @IBOutlet weak var thumbnail2: UIImageView!
    @IBOutlet weak var thumbnail3: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        thumbnail1.layer.cornerRadius = 60
        thumbnail2.layer.cornerRadius = 60
        thumbnail3.layer.cornerRadius = 60
        
        thumbnail1.layer.borderWidth = 5.0
        thumbnail2.layer.borderWidth = 5.0
        thumbnail3.layer.borderWidth = 5.0
        
        thumbnail1.layer.borderColor = UIColor.gray.cgColor
        thumbnail2.layer.borderColor = UIColor.gray.cgColor
        thumbnail3.layer.borderColor = UIColor.gray.cgColor
    }
}

