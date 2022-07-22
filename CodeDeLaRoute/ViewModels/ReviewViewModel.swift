//
//  ReviewViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 03/06/2022.
//

import Foundation
import SwiftUI

class ReviewViewModel: StudyProtocol{
    @Published var allFamiliarQuestionPs = [QuestionProgressApp]()
    @Published var weakQuestionPs = [QuestionProgressApp]()
    @Published var mediumQuestionPs = [QuestionProgressApp]()
    @Published var strongQuestionPs = [QuestionProgressApp]()
    @Published var favoriteQuestionPs = [QuestionProgressApp]()
    @Published var questionProgressApps = [QuestionProgressApp]()
    @Published var isShowNoQuestion : Bool = false
    @Published var answerQuestion = 0
    @Published var navigtorAnswer = false
    @Published var progressBar : CGFloat = 0
    @Published var isBack: Bool = false
    var correctNumber = 0
    var inCorrectNumber = 0
    
    
    init(){
        getAllQuestion()
    }
    
    func getAllQuestion(){
        let realm = RealmManager<QuestionProgress>(fileURL: .local)
        let allQuestionProgress = realm.queryAll()
        var questionProgessApps = [QuestionProgressApp]()
        
        for questionProgress in allQuestionProgress{
            questionProgessApps.append(QuestionProgressApp(questionProgress: questionProgress))
        }
        
        var allFamiliarQuestionPs = [QuestionProgressApp]()
        var weakQuestionPs = [QuestionProgressApp]()
        var mediumQuestionPs = [QuestionProgressApp]()
        var strongQuestionPs = [QuestionProgressApp]()
        var favoriteQuestionPs = [QuestionProgressApp]()
        
        for questionProgessApp in questionProgessApps {
            if !questionProgessApp.progress.isEmpty{
                
                allFamiliarQuestionPs.append(questionProgessApp)
                
                let average = averageProgress(progress: questionProgessApp.progress)
                
                if average >= 0.8{
                    strongQuestionPs.append(questionProgessApp)
                }
                if average >= 0.5 && average < 0.8{
                    mediumQuestionPs.append(questionProgessApp)
                }
                if average < 0.5{
                    weakQuestionPs.append(questionProgessApp)
                }
            }
            
            if questionProgessApp.bookmark == true {
                favoriteQuestionPs.append(questionProgessApp)
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
    
    func onHeart(questionId: String){
        let index = questionProgressApps.firstIndex(where: {$0.questionId == questionId})
        let now = Date().timeIntervalSince1970
        questionProgressApps[index!].lastUpdate = now
        questionProgressApps[index!].bookmark = !questionProgressApps[index!].bookmark
        bookmarkToggle(questionProgressApp: questionProgressApps[index!])
        objectWillChange.send()
    }
    
    func resetReviewAnswer(){
        if !questionProgressApps.isEmpty{
            if questionProgressApps[0].index != nil{
                questionProgressApps = questionProgressApps.sorted(by: {$0.index! < $1.index!})
            }
        }
    }
    
    func navigatorReviewQuestion(){
        correctNumber = 0
        inCorrectNumber = 0
        progressBar = 0
        for i in questionProgressApps.indices {
            questionProgressApps[i].index = i
            questionProgressApps[i].boxNumRoot = questionProgressApps[i].boxNum
            questionProgressApps[i].boxNum = 0
        }
    }
    
    func checkCorrect(answer: Answer) {
        if questionProgressApps[0].boxNum == -1{
            correctNumber += 1
            inCorrectNumber -= 1
        }
        if questionProgressApps[0].boxNum == 0{
            correctNumber += 1
        }
        questionProgressApps[0].boxNum = 1
        questionProgressApps[0].progress.append(1)
        checkAnswer(answer: answer)
    }
    func checkInCorrect(answer: Answer) {
        if questionProgressApps[0].boxNum == 1{
            correctNumber -= 1
            inCorrectNumber += 1
        }
        if questionProgressApps[0].boxNum == 0{
            inCorrectNumber += 1
        }
        questionProgressApps[0].progress.append(0)
        questionProgressApps[0].boxNum = -1
        
        checkAnswer(answer: answer)
    }
    
    func checkAnswer(answer: Answer){
        progressBar = CGFloat(correctNumber)/CGFloat(questionProgressApps.count)
        questionProgressApps[0].setLastUpdate()
        navigtorAnswer = true
        upDateWhenAnswer(questionProgressApp: questionProgressApps[0])
    }
    
    func upDateWhenAnswer(questionProgressApp : QuestionProgressApp){
        let realm = RealmManager<QuestionProgress>(fileURL: .local)
        
        let questionProgress = QuestionProgress()
        questionProgress.setValue(questionProgressApp: questionProgressApp)
        questionProgress.boxNum = questionProgressApp.boxNumRoot!
        _ = realm.update(entity: questionProgress)
    }
    
    func nextQuestion(){
        if navigtorAnswer == false { return }
        navigtorAnswer = false

        questionProgressApps = questionProgressApps.sortQuestionProgressApps()
        
        if correctNumber == questionProgressApps.count{
            resetReviewAnswer()
            isBack = true
            DispatchQueue.main.async { [self] in
                isBack = false
            }
        }
    }
}
