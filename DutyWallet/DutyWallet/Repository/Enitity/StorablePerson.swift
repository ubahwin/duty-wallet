//
//  StorablePerson.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 17.09.2023.
//

import Foundation
import RealmSwift

class StorablePerson: Object, StorableProtocol {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var role: String
    
    var model: Person {
        return Person(name: name, role: Person.Role(rawValue: role)!)
    }
}

extension Person: EntityProtocol {
    private var storable: StorablePerson {
        let realmDuty = StorablePerson()
        realmDuty.name = name
        realmDuty.role = role.rawValue
        return realmDuty
    }
    
    func toStorable() -> StorablePerson {
        return storable
    }
}

