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
    @Published var status : Status
    @Published var showSucsessAnswer = false
    
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
        self.topics = realmService.realmTopicService.getTopics()
        self.process = Process(correct: 0, inCorrect: 0, newQuestion: 0, total: 1)
        self.status = Status(status: "NEW QUESTION", color: Color.black, iconName: "", text: "")
    }
    
    
    func getListChildTopics(id: String){
        let result = realmService.realmTopicService.getChildTopics(id: id)
        self.listChildTopics = result
        
    }
    
    func reset(){
        resetQuestionView()
        process.reset()
        showSucsessAnswer = false
    }
    
    func getListQuestion(id: String){
        self.listQuestion = realmService.realmQuestion.getListQuestion(id: id)
        reset()
        createListQuestionProgress(listQuestion: listQuestion, id: id)
        setStatus(boxNum: 0)
    }
    
    func createListQuestionProgress(listQuestion: [Question], id : String){
        let array = realmService.realmQuestionProgress.getListQuestionProgress(listQuestion: listQuestion, topicId: id)
        self.listQuestionProgress = array
        var newQuestion = 0
        for questionProgres in listQuestionProgress {
            if questionProgres.boxNum == 0{
                newQuestion += 1
            }
        }
        process.newQuestion = newQuestion
        process.total = CGFloat(listQuestion.count)
        updateProcess()
        updateListQuestionProgress()
    }
    
    func getListAnswer(id: String) -> [Answer]{
        let listAnswer = (realmService.realmQuestion.getListAnswer(id: id))
        return listAnswer
    }
    
    func setStatus(boxNum: Int){
        switch boxNum{
            case 2:
            status.upDate(status: "CORRECT", color: Color.green!, iconName: "check-circle", text: "You will not see this question in a while")
            case 3:
            status.upDate(status: "INCORRECT", color: Color.red, iconName: "alert-circle", text: "You will see this question soon")
            case -1:
            status.upDate(status: "LEARNING", color: Color.yellow, iconName: "alert-circle", text: "You got this wrong last time")
            default:
            status.upDate(status: "NEW QUESTION", color: Color.black, iconName: "", text: "")
        }
    }
    
    func checkAnswer(answer: Answer){
        if process.newQuestion > 0{
            process.newQuestion -= 1
        }
        
        listQuestionProgress[0].choiceSelectedIds.append(answer.id)
        
        if answer.isCorrect{
            if listQuestionProgress[0].boxNum == 0{
                listQuestionProgress[0].boxNum = 1
                realmService.realmQuestionProgress.write(questionProgress: listQuestionProgress[0])
            }else{
                listQuestionProgress[0].boxNum = 1
                realmService.realmQuestionProgress.update(questionProgress: listQuestionProgress[0])
            }
            
            setStatus(boxNum: 2)
        }else{
            setStatus(boxNum: 3)
            if listQuestionProgress[0].boxNum == 0{
                listQuestionProgress[0].boxNum = -1
                realmService.realmQuestionProgress.write(questionProgress: listQuestionProgress[0])
            }else{
                listQuestionProgress[0].boxNum = -1
                realmService.realmQuestionProgress.update(questionProgress: listQuestionProgress[0])
            }
            inCorrectAnswer = answer.text
        }
        
        updateProcess()
        
        showCorrectAnswer = true
    }
    
    func updateProcess(){
        var correct = 0
        var inCorrect = 0
        for questionProgres in listQuestionProgress {
            if questionProgres.boxNum == 1{
                correct += 1
            }
            if questionProgres.boxNum == -1{
                inCorrect += 1
            }
        }
        process.correct = CGFloat(correct)
        process.inCorrect = CGFloat(inCorrect)
        
    }
    
    
    func getQuestion(id: String)-> Question{
        let question = listQuestion.first{$0.id == id}
        return question!
    }
    
    func updateListQuestionProgress(){
        if process.newQuestion > 0 {
            let progresQuestion = listQuestionProgress[0]
            listQuestionProgress.remove(at: 0)
            listQuestionProgress.append(progresQuestion)
        }
        if process.newQuestion == 0{
            
            if process.inCorrect > 1{
                process.newQuestion = Int(process.inCorrect)
                var listArray = listQuestionProgress.sorted( by: {$0.boxNum < $1.boxNum} )
                if process.inCorrect == 2 && (listQuestionProgress[0].questionId == listArray[0].questionId){
                    listArray.swapAt(0, 1)
                }
                listQuestionProgress = listArray
            }
            if process.inCorrect == 1{
                var listArray = listQuestionProgress.sorted( by: {$0.boxNum < $1.boxNum} )
                
                if listQuestionProgress[0].questionId == listArray[0].questionId{
                    listArray = listQuestionProgress.shuffled()
                    listQuestionProgress = listArray.sorted(by: {$0.boxNum > $1.boxNum})
                }else{
                    listQuestionProgress = listArray
                }
                
            }
        }
        setStatus(boxNum: listQuestionProgress[0].boxNum)
        resetQuestionView()
        if(process.correct == process.total){
            showSucsessAnswer = true
        }
    }
    
    func resetQuestionView(){
        inCorrectAnswer = ""
        showCorrectAnswer = false
        showExplanation = false
    }
}




