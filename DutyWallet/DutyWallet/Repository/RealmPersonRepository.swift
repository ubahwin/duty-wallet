//
//  RealmPersonRepository.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 15.09.2023.
//

import Foundation
import RealmSwift

class RealmPersonRepository: Repository {
    private let realm: Realm

    init() {
        try {
            realm = Realm()
        } catch {
            print("realm error")
        }
    }

    func create(entity: EntityPerson) {
        realm.add(entity)
    }

    func read(id: UUID) -> EntityPerson {
        return realm.object(ofType: EntityPerson.self, forPrimaryKey: id)!
    }

    func readAll() -> [EntityPerson] {
        return Array(realm.objects(EntityPerson.self))
    }

    func update(entity: EntityPerson) {
        //
    }

    func delete(entity: EntityPerson) {
        //
    }
}
