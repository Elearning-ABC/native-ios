//
//  TopicProgress.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 26/04/2022.
//

import Foundation
import RealmSwift

class TopicProgress: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var topicId: String
    @Persisted var totalQuestionNumber: Int
    @Persisted var correctNumber: Int
    @Persisted var lastUpdate: Double
}
