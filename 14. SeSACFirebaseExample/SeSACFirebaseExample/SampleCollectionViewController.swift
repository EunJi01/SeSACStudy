//
//  SampleCollectionViewController.swift
//  SeSACFirebaseExample
//
//  Created by 황은지 on 2022/10/18.
//

import UIKit
import RealmSwift

class SampleCollectionViewController: UICollectionViewController {
    
    let localRealm = try! Realm()
    var tasks: Results<Todo>!
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Todo>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tasks = localRealm.objects(Todo.self)
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration) // UICollectionViewCompositionalLayout
        collectionView.collectionViewLayout = layout // UICollectionViewLayout --> 상속 관계이기 때문에 성립
        
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = cell.defaultContentConfiguration() // UIListContentConfiguration
            
            content.image = itemIdentifier.importance < 2 ? UIImage(systemName: "person.fill") : UIImage(systemName: "person.2.fill")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 항목"
            
            cell.contentConfiguration = content // UIContentConfiguration --> (프로토콜 타입일 때) 같은 프로토콜을 채택하기 떄문에 성립
            // tableView.delegate = self 와 같은 코드에서도, delegate는 UITableViewDelegate 프로토콜 타입의 프로퍼티이기 때문에 self가 가능한 것
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        // 셀을 재사용하되, 실제 실행하는 메서드는 위의 cellRegisteration 에서 진행

        return cell
    }
}
