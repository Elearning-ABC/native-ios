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
    @Published var showCorrectAnswer = false
    @Published var inCorrectAnswer: String = ""
    @Published var showExplanation : Bool = false
    @Published var process : Process
    
    
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
        self.topics = realmService.realmTopicService.getTopics()
        self.process = Process(correct: 0, inCorrect: 0, newQuestion: 0, total: 1)
    }
    
    
    func getListChildTopics(id: String){
        let result = realmService.realmTopicService.getChildTopics(id: id)
        self.listChildTopics = result
        
    }
    
    func getListQuestion(id: String){
        resetQuestionView()
        self.listQuestion = realmService.realmQuestion.getListQuestion(id: id)
        
        var array: [QuestionProgressApp] = []
        
        for question in listQuestion {
            array.append(QuestionProgressApp(questionId: question.id, choiceSelectedIds: [], boxNum: 0))
        }
        
        self.listQuestionProgress = array
        process.reset()
        process.newQuestion = listQuestion.count
        process.total = listQuestion.count
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
    
    func checkAnswer(answer: Answer){
        process.newQuestion -= 1
        if answer.isCorrect{
            if listQuestionProgress[0].boxNum == -1{
                process.inCorrect -= 1
                process.correct += 1
            }
            if listQuestionProgress[0].boxNum == 0{ process.correct += 1}
            
            listQuestionProgress[0].boxNum = 1
        }else{
            if listQuestionProgress[0].boxNum == 0{ process.inCorrect += 1}
            if listQuestionProgress[0].boxNum == 1{
                process.correct -= 1
                process.inCorrect -= 1
                
            }
            listQuestionProgress[0].boxNum = -1
            inCorrectAnswer = answer.text
        }
        showCorrectAnswer = true
    }
    
    
    func getQuestion(id: String)-> Question{
        let question = listQuestion.first{$0.id == id}
        return question!
    }
    
    func updateListQuestionProgress(){
        if process.newQuestion > 0 {
            listQuestionProgress.swapAt(0, process.newQuestion)
        }
        resetQuestionView()
    }
    
    func resetQuestionView(){
        inCorrectAnswer = ""
        showCorrectAnswer = false
        showExplanation = false
    }
}

struct Status{
    var status: String
    var color: Color
}

struct Process{
    var correct: Int
    var inCorrect: Int
    var newQuestion: Int
    var total: Int
    
    mutating func reset(){
        self.correct = 0
        self.inCorrect = 0
    }
}
