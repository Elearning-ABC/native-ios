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
//    @Persisted var progress: Int
    @Persisted var choiceSelectedIds: List<String>
    @Persisted var boxNum: Int
//    @Persisted var times: List<Int>
//    @Persisted var round: Int
//    @Persisted var lastUpdate: Double
//    @Persisted var bookmark: Bool
}

struct QuestionProgressApp: Identifiable{
    var id: String
    var questionId: String
    var topicId: String
    var choiceSelectedIds: [String]
    var boxNum: Int
    
    init(questionProgress obj: QuestionProgress){
        id = obj.id
        questionId = obj.questionId
        topicId = obj.topicId
        var array: [String] = []
        for item in obj.choiceSelectedIds{
            array.append(item)
        }
        choiceSelectedIds = array
        boxNum = obj.boxNum
    }
}
