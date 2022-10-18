//
//  SimpleCollectionViewController.swift
//  SeSACWeek1617
//
//  Created by 황은지 on 2022/10/18.
//

import UIKit

struct User {
    let name: String
    let age: Int
}

class SimpleCollectionViewController: UICollectionViewController {
    
    //let list = ["닭곰탕", "삼계탕", "들기름김", "삼분카레", "콘소메 치킨"]
    
    var list = [
        User(name: "뽀로로", age: 3),
        User(name: "에디", age: 13),
        User(name: "해리포터", age: 33),
        User(name: "도라에몽", age: 5)
    ]
    
    // 1. cellRegistration 선언
    // dequeueConfiguredReusableCell 에서 사용할 해당 변수는 cellForItemAt 함수 밖에 선언해야 한다.
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // iOS 14+ 컬렉션뷰를 테이블뷰 스타일처럼 사용 가능 (List Configuration)
        var configration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configration.showsSeparators = false
        configration.backgroundColor = .lightGray
        
        let layout = UICollectionViewCompositionalLayout.list(using: configration)
        collectionView.collectionViewLayout = layout
        
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
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    // 3. cellRegistration 호출
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        // using: UICollectionView.CellRegistration<Cell, Item> 에서의 Cell은 Cell 타입, Item은 해당 indexPath.item의 data를 의미한다.
        
        return cell
    }
}
