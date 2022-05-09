//
//  TopicViewModels.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import SwiftUI

class PracticeViewModel: ObservableObject{
    var realmService: RealmService
    @Published var topics : [Topic]
    @Published var listChildTopics : [Topic] = []
    @Published var listQuestion : [Question] = []
    @Published var listQuestionProgress = [QuestionProgressApp]()
    @Published var showCorrectAnswer: Bool = false
    @Published var inCorrectAnswer = ""
    @Published var correctAnswer: String = ""
    @Published var showExplanation : Bool = false
    
    
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
        self.topics = realmService.realmTopicService.getTopics()
    }
    
    
    func getListChildTopics(id: String){
        let result = realmService.realmTopicService.getChildTopics(id: id)
        self.listChildTopics = result
        
    }
    
    func getListQuestion(id: String){
        self.listQuestion = realmService.realmQuestion.getListQuestion(id: id)
        
        var array: [QuestionProgressApp] = []
        
        for question in listQuestion {
            array.append(QuestionProgressApp(questionId: question.id, choiceSelectedIds: [], boxNum: 0))
        }
        
        self.listQuestionProgress = array
    }
    
    func getListAnswer(id: String) -> [Answer]{
        let listAnswer = (realmService.realmQuestion.getListAnswer(id: id))
        return listAnswer
    }
    
    func getStatus(boxNum: Int) ->Status{
        switch boxNum{
            case 1:
                return Status(status: "CORRECT", color: Color.green!)
            case -1:
                return Status(status: "INCORRECT", color: Color.red)
            case 4:
                return Status(status: "LEARNING", color: Color.yellow)
            default:
                return Status(status: "NEW QUESTION", color: Color.black)
        }
    }
    
    func updateQuestionProgress(answer: Answer){
        if answer.isCorrect{
            listQuestionProgress[0].boxNum = 1
        }else{
            listQuestionProgress[0].boxNum = -1
        }
    }
    
    
    func getQuestion(id: String)-> Question{
        let question = listQuestion.first{$0.id == id}
        return question!
    }
    
    func updateListQuestionProgress(){
        
    }
}

struct Status{
    var status: String
    var color: Color
}
