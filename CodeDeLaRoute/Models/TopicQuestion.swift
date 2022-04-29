//
//  TopicQuestion.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import RealmSwift

class TopicQuestion: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var parentId: String
    @Persisted var questionId: String
    @Persisted var mainTopicId: String
}
