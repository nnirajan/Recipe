//
//  RealmPersistenceType.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import Foundation
import RealmSwift

protocol RealmPersistenceType {
    func save(models: [Object])
    func fetch<T: Object>() -> [T]
    func fetch<T: Object>(primaryKey: Any) -> T?
    func changeModels(action: ()->())
    func deleteAll<T: Object>(ofType: T.Type)
    func delete(models: [Object])
    func deleteAll()
}

extension RealmPersistenceType {
    
    func save(models: [Object]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(models, update: .all)
        }
    }
    
    func fetch<T: Object>() -> [T] {
        let realm = try! Realm()
        let values = realm.objects(T.self)
        return Array(values)
    }
    
    func fetch<T: Object>(primaryKey: Any) -> T? {
        let realm = try! Realm()
        return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
//    func fetch<T: Object>(filter: String) -> [T] {
//        let realm = try! Realm()
//        let values = realm.objects(T.self).filter(filter)
//        return Array(values)
//    }
    
    func fetch<T: Object>(predicates: [NSPredicate] = [], filters: [String] = [], sortedBy: (String, Bool)? = nil, limit: Int = 0, setNo: Int = 0) -> [T] {
        let realmObject = try! Realm()
        var values = realmObject.objects(T.self)
        values = predicates.reduce(values) { (result, predicate) in
            return result.filter(predicate)
        }
        values = filters.reduce(values) { (result, filter) in
            return result.filter(filter)
        }
        
        if let sortedBy = sortedBy {
            values = values.sorted(byKeyPath: sortedBy.0, ascending: sortedBy.1)
        }
        
        if limit > 0 {
            let dataDroppingPrevious = values.dropFirst(limit*setNo)
            let dataSlicingToLimit = dataDroppingPrevious.prefix(limit)
            return Array(dataSlicingToLimit)
        }
        return Array(values)
    }
    
    func changeModels(action: ()->()) {
        let realm = try! Realm()
        realm.beginWrite()
        do {
            action()
            try realm.commitWrite()
        } catch {
            if realm.isInWriteTransaction { realm.cancelWrite() }
        }
    }
    
    func delete(models: [Object]) {
        let realm = try! Realm()
        realm.beginWrite()
        do {
            realm.delete(models)
            try realm.commitWrite()
        } catch {
            if realm.isInWriteTransaction { realm.cancelWrite() }
        }
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteAll<T: Object>(ofType: T.Type) {
        let realm = try! Realm()
        let objects = realm.objects(T.self)
        realm.beginWrite()
        do {
            realm.delete(objects)
            try realm.commitWrite()
        } catch {
            if realm.isInWriteTransaction { realm.cancelWrite() }
        }
    }
    
}
