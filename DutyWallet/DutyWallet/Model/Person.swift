//
//  Person.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 17.09.2023.
//

import Foundation

struct Person {
    var name: String
    var role: Role

    enum Role: String {
        case creditor
        case debtor

        var title: String {
            switch self {
            case .creditor: return "тот, кому я должен"
            case .debtor: return "тот, кто мне должен"
            }
        }
    }
}
