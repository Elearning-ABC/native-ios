//
//  TestViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/05/2022.
//

import Foundation

enum TestLevel: Int, CaseIterable{
    case easy = 1
    case medium = 2
    case hardest = 3
}

class TestViewModel: AnswerQuestionProtocol{
    @Published var testInfos = [TestInfo]()
    @Published var testProgressApps = [TestProgressApp]()
    @Published var questions = [Question]()
    @Published var indexQuestion: Int?
    @Published var indexTestProgressApp: Int?
    var testDataItems = [TestDataItem]()
    private let realmTestProgress = RealmManager<TestProgress>(fileURL: .local)
    private var corectNumber : Int = 0
    
    private var isCorrectAdded: Bool = false
    
    
    init(){
        getTestInfos()
    }
    
    func getTestInfos(){
        let realmTestInfo = RealmManager<TestInfo>(fileURL: .file)
        testInfos = realmTestInfo.queryAll()
        testInfos = testInfos.sorted(by: {$0.index < $1.index})
        
        getTestProgressApps()
    }
    
    func getTestProgresses()-> [TestProgress]{
        return realmTestProgress.queryAll()
    }
    
    func getTestProgressApps(){
        let testProgresses = getTestProgresses()
        
        for testProgress in testProgresses{
            testProgressApps.append(TestProgressApp(testProgress: testProgress))
        }
        
        createTestProgress()
    }
    
    func createTestProgress(){
        for testInfo in testInfos {
            let check = testProgressApps.contains(where: {$0.testInfoId == testInfo.id})
            var lock: Bool = false
            
            if testInfo.index == 0{
                lock = true
            }
            
            if check == false{
                let testProgressApp1 = TestProgressApp(testInfoId: testInfo.id, testSetting: 1, time: 0, status: 0, lastUpDate: 0, createDate: Date().timeIntervalSince1970, totalQuestion: testInfo.totalQuestion, correctQuestion: 0, lock: lock, currentQuestionId: "")
                
                let testProgressApp2 = TestProgressApp(testInfoId: testInfo.id, testSetting: 2, time: 0, status: 0, lastUpDate: 0, createDate: Date().timeIntervalSince1970, totalQuestion: testInfo.totalQuestion, correctQuestion: 0, lock: lock, currentQuestionId: "")
                
                let testProgressApp3 = TestProgressApp(testInfoId: testInfo.id, testSetting: 3, time: 0, status: 0, lastUpDate: 0, createDate: Date().timeIntervalSince1970, totalQuestion: testInfo.totalQuestion, correctQuestion: 0, lock: lock, currentQuestionId: "")
                
                testProgressApps.append(testProgressApp1)
                testProgressApps.append(testProgressApp2)
                testProgressApps.append(testProgressApp3)
                
                let testProgress1 = TestProgress()
                testProgress1.setValue(testProgressApp: testProgressApp1)
                _ = realmTestProgress.save(entity: testProgress1)
                
                let testProgress2 = TestProgress()
                testProgress2.setValue(testProgressApp: testProgressApp2)
                _ = realmTestProgress.save(entity: testProgress2)
                
                let testProgress3 = TestProgress()
                testProgress3.setValue(testProgressApp: testProgressApp3)
                _ = realmTestProgress.save(entity: testProgress3)
                
            }
        }
    }
    
    
    
    func getTestProgressApp(testInfoId: String)-> TestProgressApp?{
        var testProgressApps = self.testProgressApps.filter{$0.testInfoId == testInfoId}
        
        testProgressApps = testProgressApps.sorted(by: {$0.lastUpDate > $1.lastUpDate})
        
        return testProgressApps[0]
    }
    
    func getCorrectNumber(testInfoId: String)-> Int{
        var testProgressApps = self.testProgressApps.filter{$0.testInfoId == testInfoId}
        
        testProgressApps = testProgressApps.sorted(by: {$0.lastUpDate > $1.lastUpDate})
        
        return testProgressApps[0].correctQuestion
    }
    
    func getCorrectNumber(testInfoId: String, testLevel: TestLevel)->Int{
        let testProgressApp = testProgressApps.first(where: {$0.testInfoId == testInfoId && $0.testSetting == testLevel.rawValue})
        
        return testProgressApp!.correctQuestion
    }
    
    func createTest(testInfo: TestInfo, testLevel: TestLevel){
        var questionIds: [String] = []
        questions.removeAll()
        isCorrectAdded = false
        testDataItems = convertListToArray(list: testInfo.testQuestionData)
        
        for testDataItem in testDataItems{
            questionIds += testDataItem.questionIds
        }
        for questionId in questionIds {
            let question = getQuestion(questionId: questionId)
            questions.append(question)
        }
        
        let indexTestProgressApp = testProgressApps.firstIndex(where: {$0.testInfoId == testInfo.id && $0.testSetting == testLevel.rawValue})
        
        if !questions.isEmpty{
            let questionId = testProgressApps[indexTestProgressApp!].currentQuestionId
            if questionId == ""{
                indexQuestion = 0
            }else{
                indexQuestion = questions.firstIndex(where: {$0.id == questionId})
            }
            self.indexTestProgressApp = indexTestProgressApp
            corectNumber = testProgressApps[indexTestProgressApp!].correctQuestion
        }
    }
    
    func getTestProgressApp(testInfoId: String, testLevel: TestLevel)-> TestProgressApp?{
        if let indexTestProgressApp = testProgressApps.firstIndex(where: {$0.testInfoId == testInfoId && $0.testSetting == testLevel.rawValue}){
            return testProgressApps[indexTestProgressApp]
        }
        return nil
    }
    
    func nextQuestion(){
        guard let indexQuestion = indexQuestion else {
            return
        }
        if indexQuestion < questions.count - 1{
            let indexNext = indexQuestion + 1
            self.indexQuestion = indexNext
            if let indexTestProgressApp = indexTestProgressApp {
                testProgressApps[indexTestProgressApp].currentQuestionId = questions[indexNext].id
            }
        }
        
        if indexQuestion == questions.count - 1{
            testProgressApps[indexTestProgressApp!].status = 1
        }
        updateTestProgress()
        isCorrectAdded = false
    }
    
    func checkCorrect(answer: Answer) {
        guard let indexQuestion = indexQuestion else {
            return
        }
        
        addSelected(questionId: answer.questionId, answerId: answer.id)
        
        if !isCorrectAdded{
            corectNumber += 1
            isCorrectAdded = true
        }
        
        if indexQuestion < questions.count - 1{
            let indexNext = indexQuestion + 1
            saveCurrentQuestion(index: indexNext)
        }else{
            
        }
        
    }
    
    func checkInCorrect(answer: Answer) {
        guard let indexQuestion = indexQuestion else {
            return
        }
        addSelected(questionId: answer.questionId, answerId: answer.id)
        
        if isCorrectAdded{
            corectNumber -= 1
            isCorrectAdded = false
        }
        
        if indexQuestion < questions.count - 1{
            let indexNext = indexQuestion + 1
            saveCurrentQuestion(index: indexNext)
        }else{
            
        }
    }
    
    func addSelected(questionId: String, answerId: String){
        guard let indexTestProgressApp = indexTestProgressApp else {
            return
        }
        
        if let index = testProgressApps[indexTestProgressApp].answeredQuestions.firstIndex(where: {$0.questionId == questionId}){
            testProgressApps[indexTestProgressApp].answeredQuestions[index].selectedIds.append(answerId)
        }else{
            let answeredQuestionApp = AnsweredQuestionApp(questionId: questionId, selectedIds: [answerId])
            testProgressApps[indexTestProgressApp].answeredQuestions.append(answeredQuestionApp)
            updateTestProgress()
        }
    }
    
    func saveCurrentQuestion(index: Int){
        if let indexTestProgressApp = indexTestProgressApp {
            testProgressApps[indexTestProgressApp].correctQuestion = corectNumber
            testProgressApps[indexTestProgressApp].currentQuestionId = questions[index].id
            updateTestProgress()
        }
    }
    
    func updateTestProgress(){
        if let indexTestProgressApp = indexTestProgressApp {
            testProgressApps[indexTestProgressApp].lastUpDate = Date().timeIntervalSince1970
            let testProgress = TestProgress()
            testProgress.setValue(testProgressApp: testProgressApps[indexTestProgressApp])
            _ = realmTestProgress.update(entity: testProgress)
        }
        
    }
    func updateTestProgress(testProgressApp: TestProgressApp){
        let testProgress = TestProgress()
        testProgress.setValue(testProgressApp: testProgressApp)
        _ = realmTestProgress.update(entity: testProgress)
    }
    
    func updateTimeInTestProgress(time: Int){
        if let index = indexTestProgressApp {
            testProgressApps[index].time = time + testProgressApps[index].time
            updateTestProgress()
        }
    }
    
    func getTime()->Int?{
        if let indexTestProgressApp = indexTestProgressApp {
            let time = testProgressApps[indexTestProgressApp].time
            return time
        }else{
            return nil
        }
    }
    
    func onDisAppear(time: Int){
        updateTimeInTestProgress(time: time)
        indexTestProgressApp = nil
    }
    
    func submitTest(testInfo: TestInfo){
        guard let indexTestProgressApp = indexTestProgressApp else {
            return
        }
        let percentAnswer = Int(testProgressApps[indexTestProgressApp].correctQuestion*100/testInfo.totalQuestion)
        testProgressApps[indexTestProgressApp].status = 1
        
        updateTestProgress()
        //        if percentAnswer >= testInfo.percentPassed{
        if percentAnswer >= 0{
            if testInfo.index < testInfos.count - 1{
                unLockTestProgress(index: testInfo.index + 1)
            }
        }
        
    }
    
    func unLockTestProgress(index:Int){
        let testInfoId = testInfos[index].id
        
        for testLevel in TestLevel.allCases{
            let index = testProgressApps.firstIndex(where: {$0.testInfoId == testInfoId && $0.testSetting == testLevel.rawValue})
            if testProgressApps[index!].lock == true{
                return
            }else{
                testProgressApps[index!].lock = true
                updateTestProgress(testProgressApp: testProgressApps[index!])
            }
        }
    }
    
    func tryAgain(testInfo: TestInfo, testLevel: TestLevel){
        guard let indexTestProgressApp = indexTestProgressApp else {
            return
        }
        testProgressApps[indexTestProgressApp].status = 0
        testProgressApps[indexTestProgressApp].time = 0
        testProgressApps[indexTestProgressApp].answeredQuestions = []
        testProgressApps[indexTestProgressApp].correctQuestion = 0
        testProgressApps[indexTestProgressApp].currentQuestionId = ""
        
        updateTestProgress()
        
        createTest(testInfo: testInfo, testLevel: testLevel)
    }
    
    func getBookMark(questionId: String )->Bool{
        let realmQuestionProgress = RealmManager<QuestionProgress>(fileURL: .local)
        
        let questionProgresses = realmQuestionProgress.queryGroupByIdOther(id: questionId, property: .questionId)
        if questionProgresses != []{
            return questionProgresses[0].bookmark
        }
        return false
    }
    
    func onHeart(questionId: String, bookmark: Bool){
        let realmQuestionProgress = RealmManager<QuestionProgress>(fileURL: .local)
        let questionProgresses = realmQuestionProgress.queryGroupByIdOther(id: questionId, property: .questionId)
        if questionProgresses.isEmpty{
            let questionProgress = QuestionProgress()
            let topicId = getTopicId(questionId: questionId)
            if let topicId = topicId {
                questionProgress.id = "\(UUID())"
                questionProgress.questionId = questionId
                questionProgress.topicId = topicId
                questionProgress.bookmark = bookmark
            }
            _ = realmQuestionProgress.save(entity: questionProgress)
        }else{
            let questionProgressApp = QuestionProgressApp(questionProgress: questionProgresses[0])
            questionProgressApp.bookmark = bookmark
            questionProgressApp.lastUpdate = Date().timeIntervalSince1970
            let questionProgress = QuestionProgress()
            
            questionProgress.setValue(questionProgressApp: questionProgressApp)
            _ = realmQuestionProgress.update(entity: questionProgress)
        }
    }
    
    func getTopicId(questionId: String)-> String?{
        for testDataItem in testDataItems {
            for id in testDataItem.questionIds{
                if questionId == id{
                    return testDataItem.topicId
                }
            }
        }
        return nil
    }
    
    
    func getCorectNumberInTopic(testDataItem: TestDataItem) -> Double{
        guard let indexTestProgressApp = indexTestProgressApp else {
            return 0
        }
        var correct: Double = 0
        let realmAnswer = RealmManager<Answer>(fileURL: .file)
        
        let testProgressApp = testProgressApps[indexTestProgressApp]
        for questionId in testDataItem.questionIds{
            let result = testProgressApp.answeredQuestions.first(where: {$0.questionId == questionId})
            if let result = result {
                let answerId =  result.selectedIds.last
                let answer = realmAnswer.queryWithId(id: answerId!)
                if answer?.isCorrect == true{
                    correct += 1
                }
            }
        }
        return correct
    }
    
    func getNameInTopic(topicId: String) -> String{
        let realm = RealmManager<Topic>(fileURL: .file)
        let topic = realm.queryWithId(id: topicId)
        return topic!.name
    }
}
