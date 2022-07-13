//
//  TopicViewModels.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import SwiftUI

class PracticeViewModel: AnswerQuestionProtocol{
    private var realmService: RealmService
    @Published var navigtorAnswer: Bool = false
    @Published var topics : [Topic]
    @Published var listChildTopics : [Topic] = []
    @Published var listQuestion : [Question] = []
    @Published var questionProgressApps = [QuestionProgressApp]()
    @Published var process : Process
    @Published var showSucsessAnswer = false
    @Published var listTopicProgress = [TopicProgressApp]()
    
    
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
        self.topics = realmService.realmTopicService.getTopics()
        self.process = Process(correct: 0, inCorrect: 0, newQuestion: 0, total: 1, indexTopic: 0, indexParentTopic: 0, indexListChildTopic: 0, title: "")
        getListTopicProgress()
    }
    
    func getListTopicProgress(){
        let allTopics = realmService.realmTopicService.getAllTopics()
        listTopicProgress = realmService.realmTopicProgress.getListTopicProgress(listTopic: allTopics)
    }
    
    func getIndexTopicProgress(id: String)->Int{
        let obj = listTopicProgress.first{$0.topicId == id}
        let index = listTopicProgress.firstIndex(where: {$0.id == obj?.id})
        return index!
    }
    
    func getTopicsWithId(id: String)->[Topic]{
        let topicRealm = RealmManager<Topic>(fileURL: .file)
        var topics = topicRealm.queryGroupByIdOther(id: id, property: .parentId)
        topics = topics.sorted(by: {$0.name < $1.name})
        return topics
    }
    
    func getListQuestion(topicId: String)-> [Question]{
        self.listQuestion = realmService.realmQuestion.getListQuestion(id: topicId)
        
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
        let realmQuestionProgress = RealmManager<QuestionProgress>(fileURL: .local)
        
        let questions = getListQuestion(topicId: topicId)
        
        var questionProgressApps : [QuestionProgressApp] = []
        
        for question in questions {
            let questionProgresses = realmQuestionProgress.queryGroupByIdOther(id: question.id, property: .questionId)
            for questionProgress in questionProgresses{
                let questionProgressApp = QuestionProgressApp(questionProgress: questionProgress)
                questionProgressApp.question = question
                let answers = getAnswers(questionId: question.id)
                questionProgressApp.answers = answers
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
                    questionProgressApp.question = question
                    let answers = getAnswers(questionId: question.id)
                    questionProgressApp.answers = answers
                    array.append(questionProgressApp)
                }else{
                    questionProgressApp?.question = question
                    let answers = getAnswers(questionId: question.id)
                    questionProgressApp?.answers = answers
                    array.append(questionProgressApp!)
                }
            }
            questionProgressApps = array
        }
        self.questionProgressApps = questionProgressApps.sortQuestionProgressApps()
        showSucsessAnswer = false
        updateProcess()
        if(process.correct == process.total){
            showSucsessAnswer = true
        }
    }
    
    
    
    func updateBookmark(){
        let bookmark = questionProgressApps[0].bookmark
        questionProgressApps[0].bookmark = !bookmark
        realmService.realmQuestionProgress.updateBookmark(questionProgress: questionProgressApps[0])
        objectWillChange.send()
    }
    
    func checkCorrect(answer: Answer){
        if questionProgressApps[0].boxNum != 1{
            listTopicProgress[process.indexTopic].correctNumber += 1
            listTopicProgress[process.indexParentTopic].correctNumber += 1
        }
        questionProgressApps[0].boxNum = 1
        questionProgressApps[0].progress.append(1)
        updateDataProgress(answer: answer)
    }
    
    func checkInCorrect(answer: Answer){
        if questionProgressApps[0].boxNum == 1 && listTopicProgress[process.indexTopic].correctNumber > 0{
            
            listTopicProgress[process.indexTopic].correctNumber += -1
            listTopicProgress[process.indexParentTopic].correctNumber += -1
            
        }
        questionProgressApps[0].progress.append(0)
        questionProgressApps[0].boxNum = -1
        updateDataProgress(answer: answer)
    }
    
    func updateDataProgress(answer: Answer){
        questionProgressApps[0].choiceSelectedIds.append(answer.id)
        
        realmService.realmTopicProgress.write(topicProgressApp: listTopicProgress[process.indexTopic])
        realmService.realmTopicProgress.write(topicProgressApp: listTopicProgress[process.indexParentTopic])
        realmService.realmQuestionProgress.write(questionProgress: questionProgressApps[0])
        
        navigtorAnswer = true
        updateProcess()
    }
    
    func updateProcess(){
        let correct = listTopicProgress[process.indexTopic].correctNumber
        var inCorrect = 0
        for questionProgres in questionProgressApps {
            if questionProgres.boxNum == -1{
                inCorrect += 1
            }
        }
        process.total = CGFloat(questionProgressApps.count)
        process.correct = CGFloat(correct)
        process.inCorrect = CGFloat(inCorrect)
        
    }
    
    func updateListQuestionProgress(){
        
        if navigtorAnswer == false { return }
        navigtorAnswer = false
        
        questionProgressApps = questionProgressApps.sortQuestionProgressApps()
        
        if(process.correct == process.total){
            showSucsessAnswer = true
        }
    }
    
    func tryAgain(){
        listTopicProgress[process.indexTopic].correctNumber = 0
        listTopicProgress[process.indexParentTopic].correctNumber -= questionProgressApps.count
        
        realmService.realmTopicProgress.write(topicProgressApp: listTopicProgress[process.indexTopic])
        realmService.realmTopicProgress.write(topicProgressApp: listTopicProgress[process.indexParentTopic])
        
        realmService.realmQuestionProgress.updateWithTopicId(topicId: listTopicProgress[process.indexTopic].topicId)
        
        getQuestionProgressApps(topicId: questionProgressApps[0].topicId)
        
        showSucsessAnswer = false
    }
}
