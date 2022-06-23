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
    
    init(){
        self.localRealm = RealmLocal.shared.localRealm!
        self.realmFile = RealmFile.shared.realm!
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
            let key = Data(hexString: Constant.encryptionKey)
            let confige = Realm.Configuration(
                fileURL: Bundle.main.url(forResource: "db", withExtension: "realm"),
                encryptionKey: key,
                readOnly: true,
                schemaVersion: 0
            )
            realm = try Realm(configuration: confige)
        }catch{
            print("Error opening Realm file: \(error)")
        }
    }
}

class RealmLocal{
    static let shared = RealmLocal()
    var localRealm : Realm?
    
    init(){
        openRealm()
    }
    
    func openRealm(){
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        }catch{
            print("Error opening Realm local: \(error)")
        }
        
    }
    
}

func convertListToArray<T>(list: List<T>) -> [T]{
    var array: [T] = []
    for item in list{
        array.append(item)
    }
    return array
}
