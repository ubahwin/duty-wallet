//
//  StorableHistory.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 17.09.2023.
//

import Foundation
import RealmSwift

class StorableHistory: Object, StorableProtocol {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var info: String
    @Persisted var value: Double

    var model: History {
        return History(id: id, value: value, info: info)
    }
}

extension History: EntityProtocol {
    private var storable: StorableHistory {
        let realmHistory = StorableHistory()
        realmHistory.info = info
        realmHistory.value = value
        return realmHistory
    }

    func toStorable() -> StorableHistory {
        return storable
    }
}
