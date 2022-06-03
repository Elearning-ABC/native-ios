//
//  RealmService.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import RealmSwift

class RealmService {
    private(set) var realmFile: Realm
    private var localRealm: Realm
    var realmTopicService: RealmTopicService
    var realmQuestion: RealmQuestionService
    var realmQuestionProgress: RealmQuestionProgress
    var realmTopicProgress: RealmTopicProgress
    
    init(realmFile: RealmFile = RealmFile(), localRealm: RealmLocal = RealmLocal()){
        self.realmFile = RealmFile.shared.realm!
        self.localRealm = localRealm.openRealm()
        self.realmTopicService = RealmTopicService(realm: self.realmFile)
        self.realmQuestion = RealmQuestionService(realm: self.realmFile)
        self.realmQuestionProgress = RealmQuestionProgress(realm: self.localRealm)
        self.realmTopicProgress = RealmTopicProgress(realm: self.localRealm)
    }
}

class RealmFile{
    static let shared = RealmFile()
    var realm : Realm?
    
    init(){
        openRealm()
    }
    
    func openRealm(){
        
        do{
            let confige = Realm.Configuration(
                fileURL: Bundle.main.url(forResource: "db", withExtension: "realm"),
                encryptionKey: Data(hexString: Constant.encryptionKey),
                schemaVersion: 1
            )
            realm = try Realm(configuration: confige)
        }catch{
            print("Error opening Realm: \(error)")
        }
    }
}

class RealmLocal{
    private var localRealm : Realm?
    
    func openRealm()-> Realm{
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        }catch{
            print("Error opening Realm: \(error)")
        }
        return localRealm!
    }
    
}

func convertListToArray<T>(list: List<T>) -> [T]{
    var array: [T] = []
    for item in list{
        array.append(item)
    }
    return array
}
