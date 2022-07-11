//
//  ViewController.swift
//  SeSAC2Week2
//
//  Created by 황은지 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blueView.clipsToBounds = false // shadow
        blueView.layer.cornerRadius = blueView.frame.width / 2
        
        // clipsToBounds vs cornerRadius vs shadow
    }

}

