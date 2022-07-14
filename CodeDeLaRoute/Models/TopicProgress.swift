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
    
    func setValue(topicProgressApp: TopicProgressApp){
        id = topicProgressApp.id
        topicId = topicProgressApp.topicId
        totalQuestionNumber = topicProgressApp.totalQuestionNumber
        correctNumber = topicProgressApp.correctNumber
        lastUpdate = topicProgressApp.lastUpdate
    }
}

struct TopicProgressApp: Identifiable{
    var id: String
    var topicId: String
    var totalQuestionNumber: Int
    var correctNumber: Int
    var lastUpdate: Double
    
    init(topicId: String, totalQuestionNumber: Int){
        id = "\(UUID())"
        self.topicId = topicId
        self.totalQuestionNumber = totalQuestionNumber
        self.correctNumber = 0
        lastUpdate = Date().timeIntervalSince1970
    }
    init(topicProgress obj: TopicProgress){
        id = obj.id
        topicId = obj.topicId
        totalQuestionNumber = obj.totalQuestionNumber
        correctNumber = obj.correctNumber
        lastUpdate = obj.lastUpdate
    }
}
