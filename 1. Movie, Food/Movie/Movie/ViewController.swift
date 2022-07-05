//
//  ViewController.swift
//  Movie
//
//  Created by 황은지 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainPoster: UIImageView!
    @IBOutlet var thumbnail: [UIImageView]!
    @IBOutlet weak var palyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in thumbnail {
            i.layer.cornerRadius = 60
            i.layer.borderWidth = 4.0
            i.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        movieList.shuffle()
        mainPoster.image = UIImage(named: movieList[0])
        
        for i in 0...thumbnail.count - 1 {
            thumbnail[i].image = UIImage(named: movieList[i + 1])
        }
    }
}
