//
//  RealmModel.swift
//  NetworkBasic
//
//  Created by 황은지 on 2022/08/23.
//

import Foundation
import RealmSwift

class boxOffice: Object {
    @Persisted var date: String
    @Persisted var title: String
    @Persisted var releaseDate: String
    @Persisted var 
    
    @Persisted(primaryKey: true) var objectID: ObjectId

    convenience init(date: String) {
        self.init()
        self.date = date
    }
}
