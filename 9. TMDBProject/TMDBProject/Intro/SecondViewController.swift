//
//  SecondViewController.swift
//  TMDBProject
//
//  Created by 황은지 on 2022/08/16.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: TMDBViewController.reuseIdentifier) as! TMDBViewController
        let nav = UINavigationController(rootViewController: vc)
        
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.Key.isMain.rawValue)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
