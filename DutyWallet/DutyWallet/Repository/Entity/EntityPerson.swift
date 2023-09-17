//
//  EntityPerson.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 14.09.2023.
//

import Foundation
import RealmSwift

class EntityPerson: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var duties: List<EntityDuty>
}
