//
//  TopicViewModels.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation

class TopicViewModel: ObservableObject{
    var realmService: RealmService
    
    init(realmService: RealmService = RealmService()){
        self.realmService = realmService
    }
}
