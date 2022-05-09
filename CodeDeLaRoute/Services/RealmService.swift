//
//  RealmService.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 14/04/2022.
//

import Foundation
import RealmSwift

extension Data{
    init?(hexString: String) {
      let len = hexString.count / 2
      var data = Data(capacity: len)
      var i = hexString.startIndex
      for _ in 0..<len {
        let j = hexString.index(i, offsetBy: 2)
        let bytes = hexString[i..<j]
        if var num = UInt8(bytes, radix: 16) {
          data.append(&num, count: 1)
        } else {
          return nil
        }
        i = j
      }
      self = data
    }
}

class RealmService {
    private(set) var realm: Realm
    var realmTopicService: RealmTopicService
    var realmQuestion: RealmQuestionService
    
    init(realmOpen: RealmOpen = RealmOpen()){
        self.realm = realmOpen.realm
        self.realmTopicService = RealmTopicService(realm: realm)
        self.realmQuestion = RealmQuestionService(realm: realm)
    }
    
    func openRealm(){
        do{
            let config = Realm.Configuration(
            fileURL: Bundle.main.url(forResource: "db", withExtension: "realm"),
            encryptionKey: Data(hexString: Constant.encryptionKey),
            schemaVersion: 2
            )

            // Open the Realm with the configuration
            realm = try Realm(configuration: config)

            print("thanh cong")
        }catch{
            print("Error opening Realm: \(error)")
        }
    }
    
//    func setProperties(){
//        if let realm = realm{
//            self.realmTopicService = RealmTopicService(realm: realm)
//            self.realmQuestion = RealmQuestionService(realm: realm)
//        }
//    }
  
}

class RealmOpen{
    var realm : Realm
    
    init(){
        let config = Realm.Configuration(
        fileURL: Bundle.main.url(forResource: "db", withExtension: "realm"),
        encryptionKey: Data(hexString: Constant.encryptionKey),
        schemaVersion: 2
        )

        // Open the Realm with the configuration
        realm = try! Realm(configuration: config)
    }

//    func openRealm(){
//        let config = Realm.Configuration(
//        fileURL: Bundle.main.url(forResource: "db", withExtension: "realm"),
//        encryptionKey: Data(hexString: Constant.encryptionKey),
//        schemaVersion: 2
//        )
//
//        // Open the Realm with the configuration
//        realm = try! Realm(configuration: config)
//
//    }
}
