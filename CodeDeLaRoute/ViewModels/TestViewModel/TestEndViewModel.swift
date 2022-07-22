//
//  PracticeTestViewModel.swift
//  CodeDeLaRoute
//
//  Created by HongTuan on 15/07/2022.
//

import Foundation

class TestEndViewModel: ObservableObject{
    
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
}
