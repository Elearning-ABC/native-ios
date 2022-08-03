//
//  PracticeTestViewModel.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 15/07/2022.
//

import Foundation

class PracticeTestViewModel: ObservableObject{
    @Published var showReport: Bool = false
    @Published var isShowSubmitTest: Bool = false
    @Published var bookmark: Bool = false
    @Published var isShowBody: Bool = true
    
    func getBookMark(questionId: String )->Bool{
        let realmQuestionProgress = RealmManager<QuestionProgress>(fileURL: .local)
        
        let questionProgresses = realmQuestionProgress.queryGroupByIdOther(id: questionId, property: .questionId)
        if questionProgresses != []{
            return questionProgresses[0].bookmark
        }
        return false
    }
    
    func onHeart(questionId: String, testDataItems: [TestDataItem]){
        let realmQuestionProgress = RealmManager<QuestionProgress>(fileURL: .local)
        let questionProgresses = realmQuestionProgress.queryGroupByIdOther(id: questionId, property: .questionId)
        if questionProgresses.isEmpty{
            let questionProgress = QuestionProgress()
            let topicId = getTopicId(questionId: questionId, testDataItems: testDataItems)
            if let topicId = topicId {
                questionProgress.id = "\(UUID())"
                questionProgress.questionId = questionId
                questionProgress.topicId = topicId
                questionProgress.bookmark = true
            }
            _ = realmQuestionProgress.save(entity: questionProgress)
        }else{
            let questionProgressApp = QuestionProgressApp(questionProgress: questionProgresses[0])
            questionProgressApp.bookmark = !questionProgresses[0].bookmark
            questionProgressApp.lastUpdate = Date().timeIntervalSince1970
            let questionProgress = QuestionProgress()
            
            questionProgress.setValue(questionProgressApp: questionProgressApp)
            _ = realmQuestionProgress.update(entity: questionProgress)
        }
    }
    
    func getTopicId(questionId: String, testDataItems: [TestDataItem])-> String?{
        for testDataItem in testDataItems {
            for id in testDataItem.questionIds{
                if questionId == id{
                    return testDataItem.topicId
                }
            }
        }
        return nil
    }
    
    
    func getTime(testProgressApp: TestProgressApp)->Int{
        let time = testProgressApp.time
        return time
    }
    
    func getAnswered(answeredQuestionApps: [AnsweredQuestionApp])->Int{
        var answered: Int = 0
        for answeredQuestionApp in answeredQuestionApps {
            if !answeredQuestionApp.selectedIds.isEmpty{
                answered += 1
            }
        }
        return answered
    }
    
    func getCorectNumberInTopic(testDataItem: TestDataItem, testProgressApp: TestProgressApp) -> Double{
        
        var correct: Double = 0
        let realmAnswer = RealmManager<Answer>(fileURL: .file)
        
        for questionId in testDataItem.questionIds{
            let result = testProgressApp.answeredQuestionApps.first(where: {$0.questionId == questionId})
            if let result = result {
                let answerId =  result.selectedIds.last
                if let answerId = answerId{
                    let answer = realmAnswer.queryWithId(id: answerId)
                    if answer?.isCorrect == true{
                        correct += 1
                    }
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
    
    func getNextTestInfo(testInfos: [TestInfo], index: Int)->TestInfo?{
        if index < testInfos.count - 1{
            let testInfo = testInfos.first(where: {$0.index == (index + 1)})
            return testInfo
        }else{
            return nil
        }
    }
    
    func getProgress(selectedIds: [String])-> [Int]{
        
        if selectedIds.isEmpty{
            return [0]
        }else{
            let realm = RealmManager<Answer>(fileURL: .file)
            let answer = realm.queryWithId(id: selectedIds.first!)
            if answer!.isCorrect{
                return [1]
            }else{
                return [0]
            }
        }
        
    }
}
