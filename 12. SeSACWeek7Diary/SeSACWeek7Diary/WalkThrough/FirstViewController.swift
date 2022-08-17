//
//  FirstViewController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        starImageView.image = UIImage(systemName: "star.fill")
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 25)
        view.backgroundColor = .red
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        
        blackView.backgroundColor = .black
        blackView.alpha = 0
        
        animateTutorialLabel()
    }
    
    func animateTutorialLabel() {
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
            self.view.backgroundColor = .yellow
            //self.blackView.layoutIfNeeded()
        } completion: { _ in
            self.animateBlackView()
            self.animateImageView()
        }
    }
    
    func animateBlackView() {
        UIView.animate(withDuration: 3) {
            self.blackView.transform = CGAffineTransform(scaleX: 3, y: 1)
            self.blackView.alpha = 1
        } completion: { _ in
            print("complete")
        }
    }
    
    func animateImageView() {
        UIView.animate(withDuration: 1, delay: 0, options: .repeat) {
            self.starImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
}
