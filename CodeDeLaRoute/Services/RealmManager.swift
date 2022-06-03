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
    func query(with predicate: NSPredicate, sortDesscriptors: [NSSortDescriptor]) -> [Entity]
    
    func save(entity: Entity) -> Bool
    func save(entities: [Entity])-> [Bool]
    
    func delete(entity: Entity) -> Bool
    func delete(entities: [Entity]) ->Bool
    func deleteAll() -> Bool
}

class RealmManager<T: Object>: RealmServicceProtocol{
    typealias Entity = T
    
    private let configuration: Realm.Configuration
    
    private var realm: Realm?{
        return try? Realm(configuration: self.configuration)
    }
    
    init(){
        self.configuration = Realm.Configuration(
            schemaVersion: 1
        )
    }
    
    func queryAll() -> [T] {
        guard let realm = realm else {
            return []
        }
        
        let objects = realm.objects(Entity.self)
        
        return Array(objects)

    }
    
    func query(with predicate: NSPredicate, sortDesscriptors: [NSSortDescriptor]) -> [T] {
        return []
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
