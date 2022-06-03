//
//  RealmTopicProgress.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 18/05/2022.
//

import Foundation
import RealmSwift

class RealmTopicProgress{
    var realm: Realm
    
    init(realm: Realm){
        self.realm = realm
    }
    
    func getListTopicProgress(listTopic: [Topic])->[TopicProgressApp]{
        let listTopicProgress = realm.objects(TopicProgress.self)
        var array: [TopicProgressApp] = []
        
        listTopicProgress.forEach{ topicProgress in
            array.append(TopicProgressApp(topicProgress: topicProgress))
        }
        
        if listTopicProgress.count == listTopic.count{
            for item in listTopicProgress{
                let obj = TopicProgressApp(topicProgress: item)
                array.append(obj)
            }
        }else{
            for item in listTopic{
                let result = listTopicProgress.where{
                    $0.topicId == item.id
                }
                
                if result.isEmpty{
                    let topicProgress = TopicProgress(value: ["id": "\(UUID())", "topicId": item.id,"totalQuestionNumber": item.totalQuestion, "correctNumber": 0])
                    array.append(TopicProgressApp(topicProgress: topicProgress))
                }
            }
        }
        return array
    }
    
    func write(topicProgressApp obj: TopicProgressApp){
        let topicProgress = realm.object(ofType: TopicProgress.self, forPrimaryKey: obj.id)
        let now = Date().timeIntervalSince1970
        
        if topicProgress == nil {
            let newTopicProgress = TopicProgress(value: ["id": obj.id, "topicId": obj.topicId,"totalQuestionNumber": obj.totalQuestionNumber, "correctNumber": obj.correctNumber, "lastUpdate": now])
            
            try! realm.write{
                realm.add(newTopicProgress)
            }
        }else{
            update(id: obj.id, correct: obj.correctNumber)
        }
    }
    
    func update(id: String, correct: Int){
        let topicProgress = realm.objects(TopicProgress.self).filter(NSPredicate(format: "id == %@", id))
        guard !topicProgress.isEmpty else { return }
        
        try! realm.write {
            topicProgress[0].correctNumber = correct
            topicProgress[0].lastUpdate = Date().timeIntervalSince1970
            print("update success")
        }
    }
}
