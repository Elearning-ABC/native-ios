//
//  QuestionProgress.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 26/04/2022.
//

import Foundation
import RealmSwift

class QuestionProgress: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: String
    @Persisted var questionId: String
//    @Persisted var stateId: String
    @Persisted var topicId: String
    @Persisted var progress: List<Int>
    @Persisted var choiceSelectedIds: List<String>
    @Persisted var boxNum: Int
//    @Persisted var times: List<Int>
//    @Persisted var round: Int
    @Persisted var lastUpdate: Double
    @Persisted var bookmark: Bool
}

struct QuestionProgressApp: Identifiable{
    var id: String
    var questionId: String
    var topicId: String
    var progress: [Int]
    var choiceSelectedIds: [String]
    var boxNum: Int
    var lastUpdate: Double
    var bookmark: Bool
    
    init(questionProgress obj: QuestionProgress){
        id = obj.id
        questionId = obj.questionId
        topicId = obj.topicId
        let progress = convertListToArray(list: obj.progress)
        self.progress = progress
        let choiceSelectedIds = convertListToArray(list: obj.choiceSelectedIds)
        self.choiceSelectedIds = choiceSelectedIds
        boxNum = obj.boxNum
        lastUpdate = obj.lastUpdate
        bookmark = obj.bookmark
    }
}


