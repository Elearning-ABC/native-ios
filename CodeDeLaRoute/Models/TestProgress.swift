//
//  TestProgress.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 28/06/2022.
//

import Foundation
import RealmSwift

class TestProgress: Object, Identifiable{
    @Persisted(primaryKey: true) var id: String = "\(UUID())"
    @Persisted var testInfoId: String
    @Persisted var testSetting: Int
    @Persisted var time: Int
    @Persisted var status: Int
    @Persisted var lastUpDate: Double
    @Persisted var createDate: Double
    @Persisted var totalQuestion: Int
    @Persisted var correctQuestion: Int
    @Persisted var lock: Bool
    @Persisted var currentQuestionId: String
    @Persisted var answeredQuestions: List<AnsweredQuestion>
    
    func setValue(testProgressApp: TestProgressApp){
        id = testProgressApp.id
        testInfoId = testProgressApp.testInfoId
        testSetting = testProgressApp.testSetting
        time = testProgressApp.time
        status = testProgressApp.status
        lastUpDate = testProgressApp.lastUpDate
        createDate = testProgressApp.createDate
        totalQuestion = testProgressApp.totalQuestion
        correctQuestion = testProgressApp.correctQuestion
        lock = testProgressApp.lock
        currentQuestionId = testProgressApp.currentQuestionId
        let answeredQuestions = List<AnsweredQuestion>()
        for answeredQuestionApp in testProgressApp.answeredQuestions{
            let answeredQuestion = AnsweredQuestion()
            answeredQuestion.setValue(answeredQuestionApp: answeredQuestionApp)
            answeredQuestions.append(answeredQuestion)
        }
        self.answeredQuestions = answeredQuestions
        
    }
}

struct TestProgressApp: Identifiable{
    var id: String = UUID().uuidString
    var testInfoId: String
    var testSetting: Int
    var time: Int
    var status: Int
    var lastUpDate: Double
    var createDate: Double
    var totalQuestion: Int
    var correctQuestion: Int
    var lock: Bool
    var currentQuestionId: String
    var answeredQuestions: [AnsweredQuestionApp]
    
    init(
    testInfoId: String,
    testSetting: Int,
    time: Int,
    status: Int,
    lastUpDate: Double,
    createDate: Double,
    totalQuestion: Int,
    correctQuestion: Int,
    lock: Bool,
    currentQuestionId: String){
        self.testInfoId = testInfoId
        self.testSetting = testSetting
        self.time = time
        self.status = status
        self.lastUpDate = lastUpDate
        self.createDate = createDate
        self.totalQuestion = totalQuestion
        self.correctQuestion = correctQuestion
        self.lock = lock
        self.currentQuestionId = currentQuestionId
        self.answeredQuestions = []
    }
    
    init(testProgress: TestProgress){
        id = testProgress.id
        testInfoId = testProgress.testInfoId
        testSetting = testProgress.testSetting
        time = testProgress.time
        status = testProgress.status
        lastUpDate = testProgress.lastUpDate
        createDate = testProgress.createDate
        totalQuestion = testProgress.totalQuestion
        correctQuestion = testProgress.correctQuestion
        lock = testProgress.lock
        currentQuestionId = testProgress.currentQuestionId
        
        var answeredQuestionApps = [AnsweredQuestionApp]()
        for item in testProgress.answeredQuestions{
            let answeredQuestionApp = AnsweredQuestionApp(answeredQuestion: item)
            answeredQuestionApps.append(answeredQuestionApp)
        }
        answeredQuestions = answeredQuestionApps
    }
}
