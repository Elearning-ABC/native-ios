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
    
    func setValue(questionProgressApp: QuestionProgressApp){
        id = questionProgressApp.id
        questionId = questionProgressApp.questionId
        topicId = questionProgressApp.topicId
        progress = convertArrayToList(array: questionProgressApp.progress)
        choiceSelectedIds = convertArrayToList(array: questionProgressApp.choiceSelectedIds)
        boxNum = questionProgressApp.boxNum
        lastUpdate = questionProgressApp.lastUpdate
        bookmark = questionProgressApp.bookmark
    }
}

class QuestionProgressApp: Identifiable, Equatable{
    static func == (lhs: QuestionProgressApp, rhs: QuestionProgressApp) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String
    var questionId: String
    var topicId: String
    var progress: [Int]
    var choiceSelectedIds: [String]
    var boxNum: Int
    var lastUpdate: Double
    var bookmark: Bool
    var index: Int?
    var answers: [Answer]?
    var question: Question?
    var boxNumRoot: Int?
    
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
    
    func setLastUpdate(){
        lastUpdate = Date().timeIntervalSince1970
    }
}


