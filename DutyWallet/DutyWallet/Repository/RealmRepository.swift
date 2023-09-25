//
//  RealmDutyRepository.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 14.09.2023.
//

import Foundation
import RealmSwift

class RealmRepository<EntityObject>: RepositoryProtocol
    where EntityObject: EntityProtocol,
          EntityObject.StoreType: Object {
    
    private let realm: Realm

    init() {
        let config = Realm.Configuration(
            schemaVersion: 5)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }
    
    func create(entity: EntityObject) throws {
        try realm.write {
            realm.add(entity.toStorable())
        }
    }
    
    func read(id: UUID) -> EntityObject? {
        let object = realm.object(ofType: EntityObject.StoreType.self, forPrimaryKey: id)?.model as? EntityObject
        return object
    }
    
    func readAll() -> [EntityObject] {
        let objects = realm.objects(EntityObject.StoreType.self)
        return objects.compactMap{ ($0).model as? EntityObject }
    }
    
    func update(entity: EntityObject) throws {
        try delete(entity: entity)
        try create(entity: entity)
    }
    
    func delete(entity: EntityObject) throws {
        try realm.write {
            let predicate = NSPredicate(format: "id == %@", entity.toStorable().id as CVarArg)
            
            if let personsToDelete = realm.objects(EntityObject.StoreType.self)
                .filter(predicate).first {
                realm.delete(personsToDelete)
            }
        }
    }
    
    var filePath: String {
        return Realm.Configuration.defaultConfiguration.fileURL!.description
    }
}
