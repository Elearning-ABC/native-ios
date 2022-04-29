//
//  Topic.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import RealmSwift

class Topic: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id : String
    @Persisted var parentId: String
    @Persisted var status: Int
    @Persisted var name: String
    @Persisted var orderIndex: Int
    @Persisted var totalQuestion: Int
    @Persisted var allowMistakes: Int
    @Persisted var numMaster: Int
    @Persisted var childrenType: Int
    @Persisted var type: Int
    @Persisted var lastUpdate: Double
    @Persisted var thumbnail: String
    @Persisted var icon: String
    @Persisted var tag: String

}
