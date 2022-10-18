//
//  SampleCollectionViewController.swift
//  SeSACFirebaseExample
//
//  Created by 황은지 on 2022/10/18.
//

import UIKit
import RealmSwift

class SampleCollectionViewController: UICollectionViewController {
    
    var tasks: Results<Todo>!
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        tasks = localRealm.objects(Todo.self)
    }
}
