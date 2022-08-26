//
//  UserDiaryRepository.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/26.
//

import UIKit
import RealmSwift

// 여러개의 테이블 => CRUD
// 어떤 메서드가 있는지 모아서 보고, 관리하기 편하도록 프로토콜 생성
protocol UserDiaryRepositoryType {
    func addItem(item: UserDiary)
    func fetch() -> Results<UserDiary>!
    func fetchSort() -> Results<UserDiary>!
    func fetchFilter() -> Results<UserDiary>!
    func fetchDate(date: Date) -> Results<UserDiary>!
    func updateFavorite(item: UserDiary)
    func deleteItem(item: UserDiary)
}

class UserDiaryRepository: UserDiaryRepositoryType {
    let localRealm = try! Realm() // struct => 같은 메모리를 참조하도록 내부적으로 설계되어있음
    
    func addItem(item: UserDiary) {
        
    }
    
    func fetch() -> Results<UserDiary>! { // 매개변수 활용해서 개선하기
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    func fetchSort() -> Results<UserDiary>! {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "regdate", ascending: false)
    }
    
    func fetchFilter() -> Results<UserDiary>! {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'")
    }
    
    func fetchDate(date: Date) -> Results<UserDiary>! {
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date)) // NSPredicate를 활용해 매개변수가 순서대로 %@에 할당
    }
    
    func updateFavorite(item: UserDiary) {
        // Realm Data Update 3가지 예시
        try! localRealm.write {
            
            // 1. 하나의 레코드에서 특정 컬럼 하나만 변경
            item.favorite = !item.favorite // item.favorite.toggle() 같은 기능
            
//            // 2. 하나의 테이블에서 특정 컬럼 전체 값을 변경
//            self.tasks.setValue(true, forKey: "favorite")
//
//            // 3. 하나의 레코드에서 여러 컬럼들이 변경
//            self.localRealm.create(UserDiary.self, value: ["objectID": self.tasks[indexPath.row].objectID, "diaryContent": "변경 테스트", "diaryTitle": "제목임"], update: .modified)
            
            print("Realm Update Succeed, reloadRows 필요")
        }
    }
    
    func deleteItem(item: UserDiary) {
        try! localRealm.write {
            localRealm.delete(item)
        }
        removeImageFromDocument(fileName: "\(item.objectID).jpg")
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로 - 이미지를 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
}
