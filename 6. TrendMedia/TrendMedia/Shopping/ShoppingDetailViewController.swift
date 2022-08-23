//
//  ShoppingDetailViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/08/23.
//

import UIKit
import RealmSwift

class ShoppingDetailViewController: UIViewController {
    
    let localRealm = try! Realm()
    var task: UserShopList?
    
    lazy var detailLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .boldSystemFont(ofSize: 24)
        if let task = task {
            view.text = """
                        Title : \(task.shopTitle)
                        Star : \(task.star)
                        Complete : \(task.complete)
                        """
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
    }
    
    func configure() {
        view.addSubview(detailLabel)
    }
    
    func setConstraints() {
        view.backgroundColor = .white
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
