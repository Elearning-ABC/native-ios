//
//  TopicViewModels.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import SwiftUI

class PraticeViewModel: ObservableObject{
    var realmService: RealmService
    @Published var topics : [Topic]
    @Published var listChildTopics : [Topic] = []
    @Published var listQuestion : [Question] = []
    
    
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
        self.topics = realmService.realmTopicService!.getTopics()
    }
    
    
    func getListChildTopics(id: String){
        let result = realmService.realmTopicService!.getChildTopics(id: id)
        self.listChildTopics = result
        
    }
    
    func getListQuestion(id: String){
        self.listQuestion = realmService.realmQuestion!.getListQuestion(id: id)
    }
    
    func getListAnswer(id: String) -> [Answer]{
        let listAnswer = (realmService.realmQuestion?.getListAnswer(id: id))
        return listAnswer!
    }
    
    func getStatus(status: Int) ->Status{
        switch status{
            case 2:
                return Status(status: "CORRECT", color: Color.green!)
            case 3:
                return Status(status: "INCORRECT", color: Color.red)
            case 4:
                return Status(status: "LEARNING", color: Color.yellow)
            default:
                return Status(status: "NEW QUESTION", color: Color.black)
        }
    }
    
    func setStatus(index: Int, status: Int){
        listQuestion[index].status = status
    }
}

struct Status{
    var status: String
    var color: Color
}
