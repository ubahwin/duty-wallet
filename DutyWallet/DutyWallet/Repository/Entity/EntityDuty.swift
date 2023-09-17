//
//  EntityDuty.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 14.09.2023.
//

import Foundation
import RealmSwift

class EntityDuty: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var creditor: EntityPerson?
    @Persisted var amount: Double
}
