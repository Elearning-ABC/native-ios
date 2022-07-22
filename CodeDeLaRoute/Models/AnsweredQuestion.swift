//
//  PassedQuestion.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 29/06/2022.
//

import Foundation
import RealmSwift

class AnsweredQuestion: Object{
    @Persisted(primaryKey: true) var id: String
    @Persisted var questionId: String
    @Persisted var selectedIds: List<String>
    
    func setValue(answeredQuestionApp: AnsweredQuestionApp){
        id = answeredQuestionApp.id
        questionId = answeredQuestionApp.questionId
        selectedIds = convertArrayToList(array: answeredQuestionApp.selectedIds)
    }
}

struct AnsweredQuestionApp: Identifiable{
    var id: String
    var questionId: String
    var selectedIds: [String]
    
    init(questionId: String, selectedIds: [String]){
        self.id = UUID().uuidString
        self.questionId = questionId
        self.selectedIds = selectedIds
    }
    
    init(answeredQuestion: AnsweredQuestion){
        id = answeredQuestion.id
        questionId = answeredQuestion.questionId
        selectedIds = convertListToArray(list: answeredQuestion.selectedIds)
    }
}
