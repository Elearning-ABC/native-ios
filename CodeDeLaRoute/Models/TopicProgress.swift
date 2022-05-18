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
    @Persisted var lastUpdate: Double = Date().timeIntervalSince1970
}

struct TopicProgressApp: Identifiable{
    var id: String
    var topicId: String
    var totalQuestionNumber: Int
    var correctNumber: Int
    var lastUpdate: Double
    
    init(topicProgress obj: TopicProgress){
        id = obj.id
        topicId = obj.topicId
        totalQuestionNumber = obj.totalQuestionNumber
        correctNumber = obj.correctNumber
        lastUpdate = obj.lastUpdate
    }
}
