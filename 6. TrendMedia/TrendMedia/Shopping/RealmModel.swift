//
//  RealmModel.swift
//  TrendMedia
//
//  Created by 황은지 on 2022/08/22.
//

import Foundation
import RealmSwift

class UserShopList: Object {
    @Persisted var shopTitle: String
    @Persisted var complete: Bool
    @Persisted var star: Bool
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(shopTitle: String) {
        self.init()
        self.shopTitle = shopTitle
        self.complete = false
        self.star = false
    }
}
