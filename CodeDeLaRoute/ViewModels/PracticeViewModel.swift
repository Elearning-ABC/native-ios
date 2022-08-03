//
//  TopicViewModels.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import SwiftUI

class PracticeViewModel: StudyProtocol{
    @Published var navigtorAnswer: Bool = false
    @Published var parentTopics = [Topic]()
    @Published var listChildTopics : [Topic] = []
    @Published var questionProgressApps = [QuestionProgressApp]()
    @Published var showSucsessAnswer = false
    @Published var topicProgressApps = [TopicProgressApp]()
    @Published var inCorrectNumber: Int = 0
    private let realmTopic = RealmManager<Topic>(fileURL: .file)
    private let realmQuestionProgress = RealmManager<QuestionProgress>(fileURL: .local)
    private let realmTopicProgress = RealmManager<TopicProgress>(fileURL: .local)

    init(){
        getParentTopics()
        getListTopicProgress()
    }
    
    private func getParentTopics(){
        let realmAppInfo = RealmManager<AppInfo>(fileURL: .file)
        let appInfo = realmAppInfo.queryAll()
        if !appInfo.isEmpty{
            parentTopics = realmTopic.queryGroupByIdOther(id: appInfo[0].id, property: .parentId)
        }
    }
    
    func getCorrectNumberInTopic(topicId: String)-> Double{
        let topicProgressApp = topicProgressApps.first(where: {$0.topicId == topicId})
        if let topicProgressApp = topicProgressApp {
            return Double(topicProgressApp.correctNumber)
        }else{
            return 0
        }
    }
    
    func getListTopicProgress(){
        let topicProgresses = realmTopicProgress.queryAll()
        for topicProgress in topicProgresses {
            topicProgressApps.append(TopicProgressApp(topicProgress: topicProgress))
        }
        let topics = realmTopic.queryAll()
        for topic in topics {
            let topicProgressApp = topicProgressApps.first(where: {$0.topicId == topic.id})
            if topicProgressApp == nil{
                let topicProgressApp = TopicProgressApp(topicId: topic.id, totalQuestionNumber: topic.totalQuestion)
                topicProgressApps.append(topicProgressApp)
            }
        }
    }
    
    func getIndexTopicProgress(topicId: String)->Int{
        let obj = topicProgressApps.first{$0.topicId == topicId}
        let index = topicProgressApps.firstIndex(where: {$0.id == obj?.id})
        return index!
    }
    
    func getIndexParentTopicProgress(topicId: String)->Int{
        let topic = realmTopic.queryWithId(id: topicId)
        return getIndexTopicProgress(topicId: topic!.parentId)
    }
    
    func getIndexChildTopics(topicId: String)-> Int{
        return listChildTopics.firstIndex(where: {$0.id == topicId})!
    }
    
    func getTopicsWithId(id: String)->[Topic]{
        let topicRealm = RealmManager<Topic>(fileURL: .file)
        var topics = topicRealm.queryGroupByIdOther(id: id, property: .parentId)
        topics = topics.sorted(by: {$0.name < $1.name})
        return topics
    }
    
    func getListQuestion(topicId: String)-> [Question]{
        let realmTopicQuestion = RealmManager<TopicQuestion>(fileURL: .file)
        let listTopicQuestion = realmTopicQuestion.queryGroupByIdOther(id: topicId, property: .parentId)
        
        let realmQuestion = RealmManager<Question>(fileURL: .file)
        var listQuestions : [Question] = []
        for topicQestion in listTopicQuestion{
            let question = realmQuestion.queryWithId(id: topicQestion.questionId)
            listQuestions.append(question!)
        }
        return listQuestions
    }
    
    func getQuestionProgressApps(topicId: String){
        let questions = getListQuestion(topicId: topicId)
        
        var questionProgressApps : [QuestionProgressApp] = []
        
        for question in questions {
            let questionProgresses = realmQuestionProgress.queryGroupByIdOther(id: question.id, property: .questionId)
            for questionProgress in questionProgresses{
                let questionProgressApp = QuestionProgressApp(questionProgress: questionProgress)
                questionProgressApps.append(questionProgressApp)
            }
        }
        if questions.count != questionProgressApps.count{
            var array : [QuestionProgressApp] = []
            for question in questions {
                let questionProgressApp = questionProgressApps.first(where: {$0.questionId == question.id})
                if questionProgressApp == nil{
                    let questionProgressApp = QuestionProgressApp(questionProgress: QuestionProgress())
                    questionProgressApp.id = "\(UUID())"
                    questionProgressApp.questionId = question.id
                    questionProgressApp.topicId = topicId
                    array.append(questionProgressApp)
                }
            }
            questionProgressApps.append(contentsOf: array)
        }
        
        self.questionProgressApps = questionProgressApps.sortQuestionProgressApps()
        print("log start count question:",questionProgressApps.count)
        getIncorectNumber()
        showSucsessAnswer = false
        checkSucseesAnswer(topicId: topicId)
    }

    func onHeart(){
        let bookmark = questionProgressApps[0].bookmark
        questionProgressApps[0].bookmark = !bookmark
        bookmarkToggle(questionProgressApp: questionProgressApps[0])
        objectWillChange.send()
    }
    
    func checkCorrect(answer: Answer){
        let topicId = questionProgressApps[0].topicId
        let indexTopic = getIndexTopicProgress(topicId: topicId)
        let indexParentTopic = getIndexParentTopicProgress(topicId: topicId)
        
        if questionProgressApps[0].boxNum != 1{
            topicProgressApps[indexTopic].correctNumber += 1
            topicProgressApps[indexParentTopic].correctNumber += 1
        }
        questionProgressApps[0].boxNum = 1
        questionProgressApps[0].progress.append(1)
        updateWhenCheckAnswer(answer: answer, indexTopic: indexTopic, indexParentTopic: indexParentTopic)
    }
    
    func checkInCorrect(answer: Answer){
        let topicId = questionProgressApps[0].topicId
        let indexTopic = getIndexTopicProgress(topicId: topicId)
        let indexParentTopic = getIndexParentTopicProgress(topicId: topicId)
        if questionProgressApps[0].boxNum == 1 && topicProgressApps[indexTopic].correctNumber > 0{
            topicProgressApps[indexTopic].correctNumber += -1
            topicProgressApps[indexParentTopic].correctNumber += -1
        }
        questionProgressApps[0].progress.append(0)
        questionProgressApps[0].boxNum = -1
        updateWhenCheckAnswer(answer: answer, indexTopic: indexTopic, indexParentTopic: indexParentTopic)
    }
    
    func updateWhenCheckAnswer(answer: Answer, indexTopic: Int, indexParentTopic: Int){
        questionProgressApps[0].choiceSelectedIds.append(answer.id)
        questionProgressApps[0].setLastUpdate()
        navigtorAnswer = true
        updateTopicProgress(topicProgressApp: topicProgressApps[indexTopic])
        updateTopicProgress(topicProgressApp: topicProgressApps[indexParentTopic])
        updateQuestionProgress(questionProgressApp: questionProgressApps[0])
        getIncorectNumber()
    }
    
    func getIncorectNumber(){
        var inCorrectNumber = 0
        for questionProgressApp in questionProgressApps {
            if questionProgressApp.boxNum == -1 {
                inCorrectNumber += 1
            }
        }
        self.inCorrectNumber = inCorrectNumber
    }
    
    func updateQuestionProgress(questionProgressApp: QuestionProgressApp){
        let questionProgress = QuestionProgress()
        questionProgress.setValue(questionProgressApp: questionProgressApp)
        questionProgress.lastUpdate = Date().timeIntervalSince1970
        
        let topicProgressCheck  = realmTopicProgress.queryWithId(id: questionProgress.id)
        if topicProgressCheck != nil{
            _ = realmQuestionProgress.update(entity: questionProgress)
        }else{
            _ = realmQuestionProgress.save(entity: questionProgress)
        }
    }
    
    func updateTopicProgress(topicProgressApp: TopicProgressApp){
        let topicProgress = TopicProgress()
        topicProgress.setValue(topicProgressApp: topicProgressApp)
        topicProgress.lastUpdate = Date().timeIntervalSince1970
        
        let topicProgressCheck  = realmTopicProgress.queryWithId(id: topicProgress.id)
        if topicProgressCheck != nil{
            _ = realmTopicProgress.update(entity: topicProgress)
        }else{
            _ = realmTopicProgress.save(entity: topicProgress)
        }
    }
    
    func nextQuestion(){
        if navigtorAnswer == false { return }
        navigtorAnswer = false
        questionProgressApps = questionProgressApps.sortQuestionProgressApps()
        checkSucseesAnswer(topicId: questionProgressApps[0].topicId)
    }
    
    func checkSucseesAnswer(topicId: String){
//        let topicId = questionProgressApps[0].topicId
        let indexTopic = getIndexTopicProgress(topicId: topicId)
        print("correct number:",topicProgressApps[indexTopic].correctNumber)
        print("count questionProgressApps:",questionProgressApps.count)
        if topicProgressApps[indexTopic].correctNumber == questionProgressApps.count{
            showSucsessAnswer = true
        }
    }
    
    func tryAgain(){
        let topicId = questionProgressApps[0].topicId
        
        let indexTopic = getIndexTopicProgress(topicId: topicId)
        let indexParentTopic = getIndexParentTopicProgress(topicId: topicId)
        topicProgressApps[indexTopic].correctNumber = 0
        topicProgressApps[indexParentTopic].correctNumber -= questionProgressApps.count
        
        updateTopicProgress(topicProgressApp: topicProgressApps[indexTopic])
        updateTopicProgress(topicProgressApp: topicProgressApps[indexParentTopic])
        updateQuestionProgresses()
        
        getQuestionProgressApps(topicId: questionProgressApps[0].topicId)
        
        showSucsessAnswer = false
    }
    
    func updateQuestionProgresses(){
        for questionProgressApp in questionProgressApps {
            questionProgressApp.boxNum = 0
            updateQuestionProgress(questionProgressApp: questionProgressApp)
        }
    }
}
