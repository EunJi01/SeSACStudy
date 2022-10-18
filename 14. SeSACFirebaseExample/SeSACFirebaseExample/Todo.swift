//
//  Todo.swift
//  SeSACFirebaseExample
//
//  Created by 황은지 on 2022/10/13.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var importance: Int
    @Persisted var detail: List<DetailTodo>
    @Persisted var memo: Memo? // EmbeddedObject는 항상 Optional
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, importance: Int) {
        self.init()
        self.title = title
        self.importance = importance
    }
}

class DetailTodo: Object {
    @Persisted var detailTitle: String
    @Persisted var favorite: Bool // 기본값 false
    @Persisted var deadline: Date // 기본값 1970-01-01T00:00:00.000Z
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    @Persisted(originProperty: "detail") var todo: LinkingObjects<Todo>
    
    convenience init(detailTitle: String, favorite: Bool) {
        self.init()
        self.detailTitle = detailTitle
        self.favorite = favorite
    }
}

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
}
