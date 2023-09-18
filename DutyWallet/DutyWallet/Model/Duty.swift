//
//  Duty.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 15.09.2023.
//

import Foundation
import RealmSwift

struct Duty: Identifiable {
    var id: UUID
    var amount: Double
    var person: Person
    var historyList: [History]
}
