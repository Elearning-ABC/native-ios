//
//  RealmManager.swift
//  CodeDeLaRoute
//
//  Created by Nhung Nguyen on 31/05/2022.
//

import Foundation
import RealmSwift

protocol RealmServicceProtocol{
    associatedtype Entity
    
    func queryAll() -> [Entity]
    func queryWithId(id: String) -> Entity?
    func queryGroupByIdOther(id: String, property: Property)->[Entity]
    
    func save(entity: Entity) -> Bool
    func save(entities: [Entity])-> [Bool]
    
    func update(entity: Entity)-> Bool
    
    func delete(entity: Entity) -> Bool
    func delete(entities: [Entity]) ->Bool
    func deleteAll() -> Bool
}

enum Property: String{
    case parentId = "parentId"
    case questionId = "questionId"
}

class RealmManager<T: Object>: RealmServicceProtocol{
    typealias Entity = T
    
    private let configuration: Realm.Configuration
    
    private var realm: Realm?{
        return try? Realm(configuration: self.configuration)
    }
    
    enum fileURL{
        case file
        case local
    }
    
    
    
    init(fileURL: fileURL){
        switch fileURL {
        case .file:
            let key = Data(hexString: Constant.encryptionKey)
            self.configuration = Realm.Configuration(
                fileURL: Bundle.main.url(forResource: "db", withExtension: "realm"),
                encryptionKey: key,
                readOnly: true,
                schemaVersion: 0
            )
        case .local:
            self.configuration = Realm.Configuration(
                schemaVersion: 1
            )
        }
    }
    
    func queryAll() -> [T] {
        guard let realm = realm else {
            return []
        }
        
        let objects = realm.objects(Entity.self)
        
        return Array(objects)

    }
    
    func queryWithId(id: String) -> T?{
        guard let realm = realm else {
            return nil
        }
        let object = realm.object(ofType: T.self, forPrimaryKey: id)
        return object
    }
    
    func queryGroupByIdOther(id: String, property : Property) -> [T] {
        guard let realm = realm else {
            return []
        }
        let objects = realm.objects(T.self).filter(NSPredicate(format: "\(property.rawValue) == %@", id))
        
        return Array(objects)
    }
    
    func save(entity: T) -> Bool {
        guard let realm = realm else {
            return false
        }
        do{
            try realm.write{
                realm.add(entity, update: .all)
                realm.refresh()
            }
            return true
        }catch{
            print("save error:",entity)
            return false
        }
    }
    
    func update(entity: T) -> Bool {
        guard let realm = realm else {
            return false
        }
        do{
            try realm.write{
                realm.add(entity, update: .modified)
                realm.refresh()
            }
            return true
        }catch{
            print("Update error:",entity)
            return false
        }
    }
    
    func save(entities: [T]) -> [Bool] {
        return [true]
    }
    
    func delete(entity: T) -> Bool {
        return true
    }
    
    func delete(entities: [T]) -> Bool {
        return true
    }
    
    func deleteAll() -> Bool {
        return true
    }
    
    
    
    
}
