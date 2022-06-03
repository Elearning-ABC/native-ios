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
    
    func getAll()->[QuestionProgressApp]{
        let list = realm.objects(QuestionProgress.self)
        var array: [QuestionProgressApp] = []
        
        list.forEach{
            item in
            array.append(QuestionProgressApp(questionProgress: item))
        }
        return array
    }
    
    func write(questionProgress obj: QuestionProgressApp){
        let questionProgress = realm.object(ofType: QuestionProgress.self, forPrimaryKey: obj.id)
        let now = Date().timeIntervalSince1970
        if questionProgress == nil{
            let questionProgress = QuestionProgress(value: ["id": obj.id, "questionId":obj.questionId,"topicId": obj.topicId, "progress" : obj.progress,"choiceSelectedIds": obj.choiceSelectedIds, "boxNum": obj.boxNum, "lastUpdate": now, "bookmark": obj.bookmark])
            
            try! realm.write {
                realm.add(questionProgress)
                print("add success")
            }
        }else{
            update(questionProgress: obj)
        }
        
    }
    
    func update(questionProgress obj: QuestionProgressApp){
        let questionProgress = realm.objects(QuestionProgress.self).filter(NSPredicate(format: "id == %@", obj.id))
        let now = Date().timeIntervalSince1970
        guard !questionProgress.isEmpty else { return }
        print(questionProgress)
        
        try! realm.write {
            questionProgress[0].boxNum = obj.boxNum
            questionProgress[0].choiceSelectedIds.append(obj.choiceSelectedIds.last!)
            questionProgress[0].progress.append(obj.progress.last!)
            questionProgress[0].lastUpdate = now
            print("update success")
        }
    }
    
    func updateBookmark(questionProgress obj: QuestionProgressApp){
        let questionProgress = realm.objects(QuestionProgress.self).filter(NSPredicate(format: "id == %@", obj.id))
        let now = Date().timeIntervalSince1970
        
        if questionProgress.isEmpty{
            write(questionProgress: obj)
        } else {
            try! realm.write {
                questionProgress[0].bookmark = obj.bookmark
                questionProgress[0].lastUpdate = now
                print("update success")
            }
        }
    }
    
    func updateWithTopicId(topicId: String){
        let questionProgress = realm.objects(QuestionProgress.self).filter(NSPredicate(format: "topicId == %@", topicId))
        guard !questionProgress.isEmpty else { return }
        
        try! realm.write {
            for questionProgres in questionProgress{
                questionProgres.boxNum = 0
                questionProgres.lastUpdate = Date().timeIntervalSince1970
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
                let questionProgress = QuestionProgress(value: ["id": "\(UUID())", "questionId":question.id,"topicId": topicId, "progress": [], "choiceSelectedIds": [], "boxNum": 0, "bookmark": false])
                array.append(QuestionProgressApp(questionProgress: questionProgress))
            }
        }else{
            if listQuestion.count == array.count{
                let arraySorted = array.sorted( by: {$0.boxNum < $1.boxNum} )
                array = arraySorted
            }else{
                var listQuestionProgress: [QuestionProgressApp] = []
                for question in listQuestion{
                    let objs = list.where{
                        $0.questionId == question.id
                    }
                    if objs.isEmpty{
                        let questionProgress = QuestionProgress(value: ["id": "\(UUID())", "questionId":question.id,"topicId": topicId, "progress": [], "choiceSelectedIds": [], "boxNum": 0, "bookmark": false])
                        listQuestionProgress.append(QuestionProgressApp(questionProgress: questionProgress))
                    }else{
                        listQuestionProgress.append(QuestionProgressApp(questionProgress: objs[0]))
                    }
                }
                
                var index = 0
                for i in listQuestionProgress.indices{
                    if listQuestionProgress[i].boxNum == 0{
                        listQuestionProgress.swapAt(index, i)
                        index += 1
                    }
                }
                array = listQuestionProgress
            }
        }
        
        return array

    }
}
