//
//  AnswerQuestion.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 12/07/2022.
//
import Foundation

protocol StudyProtocol: ObservableObject{
    var navigtorAnswer: Bool {get set}
    func checkCorrect(answer: Answer)
    func checkInCorrect(answer: Answer)
    func nextQuestion()
}

extension StudyProtocol{
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
    
    func bookmarkToggle(questionProgressApp : QuestionProgressApp){
        let realm = RealmManager<QuestionProgress>(fileURL: .local)
        let questionProgress = realm.queryWithId(id: questionProgressApp.id)
        let questionProgressUpdate = QuestionProgress()
        if let questionProgress = questionProgress {
            let questionProgressAppUpdate = QuestionProgressApp(questionProgress: questionProgress)
            questionProgressAppUpdate.bookmark = questionProgressApp.bookmark
            questionProgressUpdate.setValue(questionProgressApp: questionProgressAppUpdate)
        }else{
            questionProgressUpdate.setValue(questionProgressApp: questionProgressApp)
        }
        questionProgressUpdate.lastUpdate = Date().timeIntervalSince1970
        let result = realm.update(entity: questionProgressUpdate)
        if result{
            print("changed bookmark")
        }
    }
    
}
