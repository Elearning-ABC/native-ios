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
    private let encryptionKey: String = "0100006f00010000000300000000020000007b000000000000000300000700007b000000002b00000000000c00002d0000004d0000030000002c000000000906"
    
    init(){
        openRealm()
    }
    
    func openRealm(){
        do{
            let key = Data(hexString: encryptionKey)
            let confige = Realm.Configuration(
                fileURL: Bundle.main.url(forResource: "asvab", withExtension: "realm"),
                encryptionKey: key,
                readOnly: true,
                schemaVersion: 2
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

func convertArrayToList<T>(array: [T]) -> List<T>{
    let list = List<T>()
    for item in array{
        list.append(item)
    }
    return list
}

