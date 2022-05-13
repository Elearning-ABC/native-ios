//
//  RealmQuestionProgress.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 12/05/2022.
//

import Foundation
import RealmSwift

class RealmQuestionProgress{
    var realm: Realm
    
    init(realm: Realm){
        self.realm = realm
    }
    
    func write(questionProgress obj: QuestionProgressApp){
        
        let questionProgress = QuestionProgress(value: ["id": obj.id, "questionId":obj.questionId,"topicId": obj.topicId, "choiceSelectedIds": obj.choiceSelectedIds, "boxNum": obj.boxNum])
        
        try! realm.write {
            realm.add(questionProgress)
            print("add success")
        }
    }
    
    func update(questionProgress obj: QuestionProgressApp){
        let questionProgress = realm.objects(QuestionProgress.self).filter(NSPredicate(format: "id == %@", obj.id))
        guard !questionProgress.isEmpty else { return }
        
        try! realm.write {
            questionProgress[0].boxNum = obj.boxNum
            questionProgress[0].choiceSelectedIds.removeAll()
            for choice in obj.choiceSelectedIds{
                questionProgress[0].choiceSelectedIds.append(choice)
            }
            print("update success")
        }
    }
    
    func getListQuestionProgress(listQuestion: [Question],topicId: String)-> [QuestionProgressApp]{
        let list = realm.objects(QuestionProgress.self)
        
        let result = list.where{
            $0.topicId == topicId
        }
        var array: [QuestionProgressApp] = []
        
        result.forEach{
            item in
            array.append(QuestionProgressApp(questionProgress: item))
            
        }
        
        for question in listQuestion{
            for item in array {
                if question.id != item.questionId{
                    let questionProgress = QuestionProgress(value: ["id": "\(UUID())", "questionId":question.id,"topicId": topicId, "choiceSelectedIds": [], "boxNum": 0])
                    array.append(QuestionProgressApp(questionProgress: questionProgress))
                }
            }
        }
        
        return array

    }
}
