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
