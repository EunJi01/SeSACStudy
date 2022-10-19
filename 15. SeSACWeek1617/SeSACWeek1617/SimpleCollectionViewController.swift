//
//  SimpleCollectionViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/18.
//

import UIKit

struct User: Hashable {
    let id = UUID().uuidString
    let name: String
    let age: Int
}

//class User: Hashable {
//    static func == (lhs: User, rhs: User) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//
//    let id = UUID().uuidString
//    let name: String
//    let age: Int
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}

class SimpleCollectionViewController: UICollectionViewController {
    
    var list = [
        User(name: "뽀로로", age: 3),
        User(name: "뽀로로", age: 3),
        User(name: "해리포터", age: 33),
        User(name: "도라에몽", age: 5)
    ]
    
    // 1. cellRegistration 선언
    // dequeueConfiguredReusableCell 에서 사용할 해당 변수는 cellForItemAt 함수 밖에 선언해야 한다.
    // 커스텀 셀을 사용 할 경우에는 여기에서 UICollectionViewListCell를 커스텀 셀 타입으로 지정한다.
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기존 방식과 차이점 : Identifier가 필요하지 않고, Struct 기반이기 때문에 셀 재사용 시 발생하는 문제가 발생하지 않는다.

        collectionView.collectionViewLayout = createLayout()
        
        // 2. cellRegistration 등록
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            //var content = cell.defaultContentConfiguration()
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.name
            content.textProperties.color = .systemIndigo
            
            content.secondaryText = "\(itemIdentifier.age)살"
            content.prefersSideBySideTextAndSecondaryText = false // secondaryText 위치 변경
            content.textToSecondaryTextVerticalPadding = 10 // 제목/부제 간격 조절
            
            content.image = itemIdentifier.age < 5 ? UIImage(systemName: "star") : UIImage(systemName: "person.fill")
            content.imageProperties.tintColor = .systemPurple
            
            cell.contentConfiguration = content
        
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .white
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2 // = borderWidth
            backgroundConfig.strokeColor = .systemCyan // = borderColor
            cell.backgroundConfiguration = backgroundConfig
            
        } // cellRegistration의 Hendler(클로저)를 초기화했을 뿐, 따로 cellRegistration를 실행시켜야 한다.
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}

extension SimpleCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        // iOS 14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (List Configuration)
        var configration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configration.showsSeparators = false
        configration.backgroundColor = .lightGray
        
        let layout = UICollectionViewCompositionalLayout.list(using: configration)
        return layout
    }
}
