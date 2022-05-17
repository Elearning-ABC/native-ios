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
        if array.isEmpty{
            for question in listQuestion{
                let questionProgress = QuestionProgress(value: ["id": "\(UUID())", "questionId":question.id,"topicId": topicId, "choiceSelectedIds": [], "boxNum": 0])
                array.append(QuestionProgressApp(questionProgress: questionProgress))
            }
        }else{
            if listQuestion.count == array.count{
                let arraySorted = array.sorted( by: {$0.boxNum < $1.boxNum} )
                array = arraySorted
            }else{
                var listQuestionProgress: [QuestionProgressApp] = []
                for question in listQuestion{
                    var check = true
                    for item in array {
                        if question.id == item.questionId{
                            check = false
                            break
                        }
                    }
                    if check{
                        let questionProgress = QuestionProgress(value: ["id": "\(UUID())", "questionId":question.id,"topicId": topicId, "choiceSelectedIds": [], "boxNum": 0])
                        listQuestionProgress.append(QuestionProgressApp(questionProgress: questionProgress))
                    }
                }
                listQuestionProgress.append(contentsOf: array)
                array = listQuestionProgress
                print(array.count)
            }
        }
        
        return array

    }
}
