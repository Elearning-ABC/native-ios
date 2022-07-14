//
//  TestDataItem.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 28/06/2022.
//

import Foundation
import RealmSwift

class TestDataItem: Object, Identifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var topicId: String
    @Persisted var times: Int
    @Persisted var questionNum: Int
    @Persisted var requiredPass: Int
    @Persisted var questionIds: List<String>
}
