//
//  ShoppingDetailViewController.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/08/23.
//

import UIKit
import RealmSwift

class ShoppingDetailViewController: UIViewController {
    
    var objectID: ObjectId?
    let localRealm = try! Realm()
    var tasks: Results<UserShopList>!

    
    lazy var detailLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .red
        //let task = localRealm.object(ofType: tasks, forPrimaryKey: objectID)
        view.text = "asdf"
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
