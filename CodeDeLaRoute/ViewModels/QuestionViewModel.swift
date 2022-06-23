//
//  QuestionViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 08/06/2022.
//

import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject{
    @Published var status : Status
    @Published var showCorrectAnswer = false
    @Published var inCorrectAnswer: String = ""
    @Published var showExplanation : Bool = false
    
    init(){
        status = Status(status: "", color: Color.white, iconName: "", text: "")
    }
    
    func setStatus(value: Int)-> Status{
            switch value{
            case -1:
            return Status(status: "LEARNING", color: Color.yellow, iconName: "alert-circle", text: "You got this wrong last time")
            case 1:
            return Status(status: "REVIEWING", color: Color.green!, iconName: "check-circle", text: "You got this question last time")
            case 2:
            return Status(status: "CORRECT", color: Color.green!, iconName: "check-circle", text: "You will not see this question in a while")
            case 3:
            return Status(status: "INCORRECT", color: Color.red, iconName: "alert-circle", text: "You will see this question soon")
            
            default:
            return Status(status: "NEW QUESTION", color: Color.black, iconName: "", text: "")
        }
    }
    
    func getListAnswer(id: String) -> [Answer]{
        let realm = RealmManager<Answer>(fileURL: .file)
        let listAnswer = realm.queryGroupByIdOther(id: id, property: .questionId)
        return listAnswer
    }
    
    func getQuestion(questionId: String) -> Question{
        let realm = RealmManager<Question>(fileURL: .file)
        let question = realm.queryWithId(id: questionId)
        return question!
    }
    
    func upDateWhenAnswer(questionProgersApp obj: QuestionProgressApp){
        let realm = RealmManager<QuestionProgress>(fileURL: .local)
        let now = Date().timeIntervalSince1970
        let questionProgress = QuestionProgress(value: ["id": obj.id, "questionId":obj.questionId,"topicId": obj.topicId, "progress" : obj.progress,"choiceSelectedIds": obj.choiceSelectedIds, "boxNum": obj.boxNum, "lastUpdate": now, "bookmark": obj.bookmark])
        _ = realm.update(entity: questionProgress)
    }
    
}

struct Status{
    var status: String
    var color: Color
    var iconName: String
    var text: String
    
    mutating func upDate( status: String, color: Color, iconName: String, text: String){
        self.status = status
        self.color = color
        self.iconName = iconName
        self.text = text
    }
}
