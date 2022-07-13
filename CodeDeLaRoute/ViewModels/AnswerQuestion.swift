//
//  AnswerQuestion.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 12/07/2022.
//

import Foundation

protocol AnswerQuestionProtocol: ObservableObject{
    func checkCorrect(answer: Answer)
    func checkInCorrect(answer: Answer)
}

extension AnswerQuestionProtocol{
    func getAnswers(questionId: String) -> [Answer]{
        let realm = RealmManager<Answer>(fileURL: .file)
        var answers = realm.queryGroupByIdOther(id: questionId, property: .questionId)
//        answers.shuffle()
        return answers
    }
    
    func getQuestion(questionId: String)->Question{
        let realm = RealmManager<Question>(fileURL: .file)
        let question = realm.queryWithId(id: questionId)
        return question!
    }
    
}
