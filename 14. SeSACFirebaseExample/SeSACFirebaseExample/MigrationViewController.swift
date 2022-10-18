//
//  MigrationViewController.swift
//  SeSACFirebaseExample
//
//  Created by 황은지 on 2022/10/13.
//

import UIKit
import RealmSwift

class MigrationViewController: UIViewController {
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. fileURL
        print("FileURL: \(localRealm.configuration.fileURL)")
        
        // 2. SchemaVersion
        do {
            let version = try schemaVersionAtURL(localRealm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
        
        // 3. Todo 추가
//        for i in 1...100 {
//            let task = Todo(title: "고래밥의 할일 \(i)", importance: Int.random(in: 1...5))
//            try! localRealm.write({
//                localRealm.add(task)
//            })
//        }
        
        // 4. DetailTodo 추가
//        for i in 1...10 {
//            let task = DetailTodo(detailTitle: "양파 \(i)개 사기", favorite: true)
//            try! localRealm.write({
//                localRealm.add(task)
//            })
//        }
        
       // 특정 Todo task에 DetailTodo 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//        let detail = DetailTodo(detailTitle: "프랭크 5개 먹기", favorite: false)
//
//        try! localRealm.write({
//            task.detail.append(detail)
//
//        }
        
        // 특정 Todo task에 DetailTodo 여러개 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//        let detail = DetailTodo(detailTitle: "깡깡한 아이스크림 \(Int.random(in: 1...5))개 먹기", favorite: false)
//
//        for _ in 1...10 {
//            try! localRealm.write({
//                task.detail.append(detail)
//            })
//        }
        
        // 특정 Todo 테이블 삭제
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 7'").first else { return }
//        
//        try! localRealm.write {
//            localRealm.delete(task.detail) // Realm List 먼저 지우고
//            localRealm.delete(task) // 테스크 지우기
//        }
        
        // 특정 Todo에 메모 추가
//        guard let task = localRealm.objects(Todo.self).filter("title = '고래밥의 할일 6'").first else { return }
//
//        let memo = Memo()
//        memo.content = "이렇게 메모 내용 추가"
//        memo.date = Date()
//
//        try! localRealm.write {
//            task.memo = memo
//        }
    }
}
