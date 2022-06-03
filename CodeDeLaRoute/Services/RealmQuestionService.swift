//
//  RealmQuestionService.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 27/04/2022.
//

import Foundation
import RealmSwift

class RealmQuestionService{
    let realm: Realm
    
    init(realm: Realm){
        self.realm = realm
    }
    
    func getListTopicQuestion(id: String) -> [TopicQuestion] {
        let data = realm.objects(TopicQuestion.self)
        let result = data.where{
            $0.parentId == id
        }
        
        var array: [TopicQuestion] = []
        
        result.forEach{
            question in
            array.append(question)
            
        }
        return array
    }
    
    func getListQuestion(id: String) -> [Question] {
        let listTopicQuestion = getListTopicQuestion(id: id)
        let data = realm.objects(Question.self)
        
        var questions: [Question] = []
        
        listTopicQuestion.forEach{
            topicQuestion in
            let result = data.where{
                $0.id == topicQuestion.questionId
            }
            questions.append(result[0])
            
        }
        return questions
    }
    
    
    func getListAnswer(id: String) -> [Answer] {
        let data = realm.objects(Answer.self)
        let result = data.where{
            $0.questionId == id
        }
        
        var array: [Answer] = []
        
        result.forEach{
            answer in
            array.append(answer)
            
        }
        array.shuffle()
        return array
    }
    
    func getAnswer(id: String)-> Answer{
        let answer = realm.object(ofType: Answer.self, forPrimaryKey: id)
        return answer!
    }
    
}
