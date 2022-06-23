//
//  ReviewViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 03/06/2022.
//

import Foundation
import SwiftUI

class ReviewViewModel: ObservableObject{
    private var realmService: RealmService
    @Published var allFamiliarQuestionPs = [QuestionProgressApp]()
    @Published var weakQuestionPs = [QuestionProgressApp]()
    @Published var mediumQuestionPs = [QuestionProgressApp]()
    @Published var strongQuestionPs = [QuestionProgressApp]()
    @Published var favoriteQuestionPs = [QuestionProgressApp]()
    @Published var listQuestionProgress = [QuestionProgressApp]()
    @Published var isShowNoQuestion : Bool = false
    @Published var showImage: Bool = false
    @Published var imageString : String = ""
    @Published var namespace: Namespace.ID
    @Published var imageId: String = "0"
    
    
    init(realmService: RealmService = RealmService(), namespace: Namespace.ID){
        self.realmService = realmService
        self.status = Status(status: "NEW QUESTION", color: Color.black, iconName: "", text: "")
        self.namespace = namespace
        getAllQuestion()
    }
    
    func getAllQuestion(){
        let allQuestion = realmService.realmQuestionProgress.getAll()
        
        var allFamiliarQuestionPs = [QuestionProgressApp]()
        var weakQuestionPs = [QuestionProgressApp]()
        var mediumQuestionPs = [QuestionProgressApp]()
        var strongQuestionPs = [QuestionProgressApp]()
        var favoriteQuestionPs = [QuestionProgressApp]()
        
        for question in allQuestion{
    
            if !question.progress.isEmpty{
                
                allFamiliarQuestionPs.append(question)
                
                let average = averageProgress(progress: question.progress)
                
                if average >= 0.8{
                    strongQuestionPs.append(question)
                }
                if average >= 0.5 && average < 0.8{
                    mediumQuestionPs.append(question)
                }
                if average < 0.5{
                    weakQuestionPs.append(question)
                }
            }
            
            if question.bookmark == true {
                favoriteQuestionPs.append(question)
            }
        }
        self.allFamiliarQuestionPs = allFamiliarQuestionPs
        self.weakQuestionPs = weakQuestionPs
        self.mediumQuestionPs = mediumQuestionPs
        self.strongQuestionPs = strongQuestionPs
        self.favoriteQuestionPs = favoriteQuestionPs
    }
    
    func averageProgress(progress: [Int])-> Double{
        var total = 0
        let length = progress.count
        for i in progress{
            total += i
        }
        let average = Double(total)/Double(length)
        return average
    }
    
    func getQuestion(questionId: String) -> Question?{
        let realm = RealmManager<Question>(fileURL: .file)
        let question = realm.queryWithId(id: questionId)
        return question
    }
    
    func bookmarkToggle(questionProgressApp obj: QuestionProgressApp){
        let realm = RealmManager<QuestionProgress>(fileURL: .local)
        let now = Date().timeIntervalSince1970
        let questionProgress = QuestionProgress(value: ["id": obj.id, "questionId":obj.questionId,"topicId": obj.topicId, "progress" : obj.progress,"choiceSelectedIds": obj.choiceSelectedIds, "boxNum": obj.boxNum, "lastUpdate": now, "bookmark": !obj.bookmark])
        let result = realm.update(entity: questionProgress)
        if result{
            print("changed bookmark")
        }
    }
    // check answer question
    @Published var answerQuestion = 0
    @Published var navigtorAnswer = false
    @Published var inCorrectAnswerText = ""
    @Published var showCorrectAnswer = false
    @Published var showExplanation : Bool = false
    @Published var status : Status
    @Published var progressBar : CGFloat = 0
    var correctNumber = 0
    var inCorrectNumber = 0
    var round = false
    
    func resetReviewAnswer(){
        showExplanation = false
        showCorrectAnswer = false
        inCorrectAnswerText = ""
        correctNumber = 0
        inCorrectNumber = 0
        progressBar = 0
        round = false
    }
    
    func navigatorReviewQuestion(){
        for i in listQuestionProgress.indices {
            listQuestionProgress[i].index = i
        }
        answerQuestion = listQuestionProgress.count
        setStatus(value: listQuestionProgress[0].progress.last)
        print("navigator")
    }
    
    func checkAnswer(answer: Answer){
        if answerQuestion != 0{
            answerQuestion -= 1
        }
        
        if answer.isCorrect{
            setStatus(value: 2)
            if listQuestionProgress[0].boxNum != 1 && round{
                correctNumber += 1
                inCorrectNumber -= 1
            }
            if !round{
                correctNumber += 1
            }
            listQuestionProgress[0].boxNum = 1
            listQuestionProgress[0].progress.append(1)
        }else{
            setStatus(value: 3)
            if listQuestionProgress[0].boxNum == 1 && round{
                correctNumber -= 1
                inCorrectNumber += 1
            }
            if !round{
                inCorrectNumber += 1
            }
            listQuestionProgress[0].progress.append(0)
            listQuestionProgress[0].boxNum = -1
            
            inCorrectAnswerText = answer.text
        }
        
        
        progressBar = CGFloat(correctNumber)/CGFloat(listQuestionProgress.count)
        showExplanation = true
        showCorrectAnswer = true
        navigtorAnswer = true
        
        upDateWhenAnswer(questionProgersApp: listQuestionProgress[0])
    }
    
    func upDateWhenAnswer(questionProgersApp obj: QuestionProgressApp){
        let realm = RealmManager<QuestionProgress>(fileURL: .local)
        let now = Date().timeIntervalSince1970
        let questionProgress = QuestionProgress(value: ["id": obj.id, "questionId":obj.questionId,"topicId": obj.topicId, "progress" : obj.progress,"choiceSelectedIds": obj.choiceSelectedIds, "boxNum": obj.boxNum, "lastUpdate": now, "bookmark": obj.bookmark])
        _ = realm.update(entity: questionProgress)
    }
    
    func upDateListQuestion(mode: Binding<PresentationMode>){
        if navigtorAnswer == false { return }
        navigtorAnswer = false
        
        
        if answerQuestion > 0 {
            let progresQuestion = listQuestionProgress[0]
            listQuestionProgress.remove(at: 0)
            listQuestionProgress.append(progresQuestion)
        }
        
        if answerQuestion == 0{
            round = true
            
            if inCorrectNumber > 1{
                answerQuestion = inCorrectNumber
                var listArray = listQuestionProgress.sorted( by: {$0.boxNum < $1.boxNum} )
                if inCorrectNumber == 2 && (listQuestionProgress[0].id == listArray[0].id){
                    listArray.swapAt(0, 1)
                }
                listQuestionProgress = listArray
            }
            if inCorrectNumber == 1{
                var listArray = listQuestionProgress.sorted( by: {$0.boxNum < $1.boxNum} )
                
                if listQuestionProgress[0].id == listArray[0].id{
                    listArray = listQuestionProgress.shuffled()
                    listQuestionProgress = listArray.sorted(by: {$0.boxNum > $1.boxNum})
                }else{
                    listQuestionProgress = listArray
                }
                
            }
        }
        
        setStatus(value: listQuestionProgress[0].progress.last)
        showExplanation = false
        showCorrectAnswer = false
        inCorrectAnswerText = ""
        
        if correctNumber == listQuestionProgress.count{
            listQuestionProgress = listQuestionProgress.sorted(by: {$0.index! < $1.index!})
            mode.wrappedValue.dismiss()
        }
    }
    
    
    
    func setStatus(value: Int?){
        var check = value
        if value == nil{
            check = -1
        }
        switch check{
            case 0:
            status.upDate(status: "LEARNING", color: Color.yellow, iconName: "alert-circle", text: "You got this wrong last time")
            case 1:
            status.upDate(status: "REVIEWING", color: Color.green!, iconName: "check-circle", text: "You got this question last time")
            case 2:
            status.upDate(status: "CORRECT", color: Color.green!, iconName: "check-circle", text: "You will not see this question in a while")
            case 3:
            status.upDate(status: "INCORRECT", color: Color.red, iconName: "alert-circle", text: "You will see this question soon")
            
            default:
            status.upDate(status: "NEW QUESTION", color: Color.black, iconName: "", text: "")
        }
    }
}
