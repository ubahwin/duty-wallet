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
    }
}
