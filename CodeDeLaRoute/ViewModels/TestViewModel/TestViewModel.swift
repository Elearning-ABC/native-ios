//
//  TestViewModel.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/05/2022.
//

import Foundation

class TestViewModel: StudyProtocol{
    var navigtorAnswer: Bool = true
    @Published var testInfos = [TestInfo]()
    @Published var testProgressApps = [TestProgressApp]()
    @Published var indexQuestion: Int?
    @Published var indexTestProgressApp: Int?
    @Published var isDetailTest: Bool = false
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
            if check == false{
                var lock: Bool = false
                var answeredQuestionApps = [AnsweredQuestionApp]()
                
                if testInfo.index == 0{
                    lock = true
                }
                
                for testItemData in testInfo.testQuestionData {
                    for questionId in testItemData.questionIds {
                        let answeredQuestionApp = AnsweredQuestionApp(questionId: questionId, selectedIds: [])
                        answeredQuestionApps.append(answeredQuestionApp)
                    }
                }
                answeredQuestionApps.shuffle()
                let testProgressAppEasy = TestProgressApp(testInfoId: testInfo.id, testSetting: .easy, totalQuestion: testInfo.totalQuestion, lock: lock, answeredQuestionApps: answeredQuestionApps)
                
                let testProgressAppMedium = TestProgressApp(testInfoId: testInfo.id, testSetting: .medium, totalQuestion: testInfo.totalQuestion, lock: lock, answeredQuestionApps: answeredQuestionApps)
                
                let testProgressAppHardest = TestProgressApp(testInfoId: testInfo.id, testSetting: .hardest, totalQuestion: testInfo.totalQuestion, lock: lock, answeredQuestionApps: answeredQuestionApps)
                
                testProgressApps.append(testProgressAppEasy)
                saveTestProgress(testProgressApp: testProgressAppEasy)
                
                testProgressApps.append(testProgressAppMedium)
                saveTestProgress(testProgressApp: testProgressAppMedium)
                
                testProgressApps.append(testProgressAppHardest)
                saveTestProgress(testProgressApp: testProgressAppHardest)
            }
        }
    }
    
    func saveTestProgress(testProgressApp: TestProgressApp){
        let testProgress = TestProgress()
        testProgress.setValue(testProgressApp: testProgressApp)
        _ = realmTestProgress.save(entity: testProgress)
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
    
    func getCorrectNumber(testInfoId: String, testLevel: TestSetting)->Int{
        let testProgressApp = testProgressApps.first(where: {$0.testInfoId == testInfoId && $0.testSetting == testLevel.rawValue})
        
        return testProgressApp!.correctQuestion
    }
    
    func createTest(testInfoId: String, testSetting: TestSetting){
        isCorrectAdded = false
        let indexTestProgressApp = testProgressApps.firstIndex(where: {$0.testInfoId == testInfoId && $0.testSetting == testSetting.rawValue})
        self.indexTestProgressApp = indexTestProgressApp
        let questionId = testProgressApps[indexTestProgressApp!].currentQuestionId
        if questionId == ""{
            indexQuestion = 0
        }else{
            indexQuestion = testProgressApps[indexTestProgressApp!].answeredQuestionApps.firstIndex(where: {$0.questionId == questionId})
        }
        self.indexTestProgressApp = indexTestProgressApp
        corectNumber = testProgressApps[indexTestProgressApp!].correctQuestion
        
    }
    
    func getTestProgressApp(testInfoId: String, testLevel: TestSetting)-> TestProgressApp?{
        if let indexTestProgressApp = testProgressApps.firstIndex(where: {$0.testInfoId == testInfoId && $0.testSetting == testLevel.rawValue}){
            return testProgressApps[indexTestProgressApp]
        }
        return nil
    }
    
    func nextQuestion(){
        guard let indexQuestion = indexQuestion else {
            return
        }
        
        let totalQuestion = testProgressApps[indexTestProgressApp!].totalQuestion
        if indexQuestion < totalQuestion - 1{
            let indexNext = indexQuestion + 1
            self.indexQuestion = indexNext
            if let indexTestProgressApp = indexTestProgressApp {
                testProgressApps[indexTestProgressApp].currentQuestionId = testProgressApps[indexTestProgressApp].answeredQuestionApps[indexNext].questionId
            }
        }
        
        if indexQuestion == totalQuestion - 1{
            testProgressApps[indexTestProgressApp!].status = 1
        }
        updateTestProgress(id: testProgressApps[indexTestProgressApp!].id)
        isCorrectAdded = false
    }
    
    func checkCorrect(answer: Answer) {
        updateWhenAnwer(answer: answer)
        if !isCorrectAdded{
            corectNumber += 1
            isCorrectAdded = true
        }
    }
    
    func checkInCorrect(answer: Answer) {
        updateWhenAnwer(answer: answer)
        if isCorrectAdded{
            corectNumber -= 1
            isCorrectAdded = false
        }
    }
    
    func updateWhenAnwer(answer: Answer){
        guard let indexQuestion = indexQuestion else {
            return
        }
        testProgressApps[indexTestProgressApp!].correctQuestion = corectNumber
        let totalQuestion = testProgressApps[indexTestProgressApp!].totalQuestion
        if indexQuestion < totalQuestion - 1{
            let indexNext = indexQuestion + 1
            if let indexTestProgressApp = indexTestProgressApp {
                testProgressApps[indexTestProgressApp].currentQuestionId = testProgressApps[indexTestProgressApp].answeredQuestionApps[indexNext].questionId
            }
        }
        addSelected(questionId: answer.questionId, answerId: answer.id)
        updateTestProgress(id: testProgressApps[indexTestProgressApp!].id)
    }
    
    func addSelected(questionId: String, answerId: String){
        guard let indexTestProgressApp = indexTestProgressApp else {
            return
        }
        if let index = testProgressApps[indexTestProgressApp].answeredQuestionApps.firstIndex(where: {$0.questionId == questionId}){
            testProgressApps[indexTestProgressApp].answeredQuestionApps[index].selectedIds.append(answerId)
        }
    }
    
    func updateTestProgress(id: String){
        let index = testProgressApps.firstIndex(where: {$0.id == id})
        if let index = index {
            testProgressApps[index].lastUpDate = Date().timeIntervalSince1970
            let testProgress = TestProgress()
            testProgress.setValue(testProgressApp: testProgressApps[index])
            _ = realmTestProgress.update(entity: testProgress)
        }
    }
    
    func updateTimeInTestProgress(time: Int){
        if let index = indexTestProgressApp {
            testProgressApps[index].time = time + testProgressApps[index].time
            updateTestProgress(id: testProgressApps[index].id)
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
        
        updateTestProgress(id: testProgressApps[indexTestProgressApp].id)
        //        if percentAnswer >= testInfo.percentPassed{
        if percentAnswer >= 0{
            if testInfo.index < testInfos.count - 1{
                unLockTestProgress(index: testInfo.index + 1)
            }
        }
    }
    
    func unLockTestProgress(index:Int){
        let testInfoId = testInfos[index].id
        
        for testLevel in TestSetting.allCases{
            let index = testProgressApps.firstIndex(where: {$0.testInfoId == testInfoId && $0.testSetting == testLevel.rawValue})
            if testProgressApps[index!].lock == true{
                return
            }else{
                testProgressApps[index!].lock = true
                updateTestProgress(id: testProgressApps[index!].id)
            }
        }
    }
    
    func tryAgain(testInfoId: String, testLevel: TestSetting){
        guard let indexTestProgressApp = indexTestProgressApp else {
            return
        }
        testProgressApps[indexTestProgressApp].status = 0
        testProgressApps[indexTestProgressApp].time = 0
        testProgressApps[indexTestProgressApp].correctQuestion = 0
        testProgressApps[indexTestProgressApp].currentQuestionId = ""
        resetAnsweredQuestionApps(index: indexTestProgressApp)
        updateTestProgress(id: testProgressApps[indexTestProgressApp].id)
        
        createTest(testInfoId: testInfoId, testSetting: testLevel)
    }
    
    func resetAnsweredQuestionApps(index: Int){
        for i in testProgressApps[index].answeredQuestionApps.indices{
            testProgressApps[index].answeredQuestionApps[i].selectedIds = []
        }
    }
}
