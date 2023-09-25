//
//  StorableDuty.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 15.09.2023.
//

import Foundation
import RealmSwift

class StorableDuty: Object, StorableProtocol {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var amount: Double
    @Persisted var person: StorablePerson?
    @Persisted var historyList: List<StorableHistory>

    var model: Duty {
        return Duty(
            id: id,
            amount: amount,
            person: Person(name: person?.name ?? "", role: Person.Role(rawValue: person?.role ?? "creditor")!),
            historyList: Array(_immutableCocoaArray: historyList))
    }
}

extension Duty: EntityProtocol {
    private var storable: StorableDuty {
        let realmDuty = StorableDuty()
        let realmPerson = StorablePerson()

        let realmHistoryList = List<StorableHistory>()
        for history in historyList {
            let realmHistory = StorableHistory()
            realmHistory.id = history.id
            realmHistory.info = history.info
            realmHistory.value = history.value
            realmHistoryList.append(realmHistory)
        }

        realmPerson.name = person.name
        realmPerson.role = person.role.rawValue

        realmDuty.id = id
        realmDuty.amount = amount
        realmDuty.person = realmPerson
        realmDuty.historyList = realmHistoryList

        return realmDuty
    }

    func toStorable() -> StorableDuty {
        return storable
    }
}
