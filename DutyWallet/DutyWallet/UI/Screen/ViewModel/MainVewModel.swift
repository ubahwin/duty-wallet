//
//  MainVewModel.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 15.09.2023.
//

import Foundation
import SwiftUI

class MainVewModel<T: RepositoryProtocol>: ObservableObject where T.Entity == Duty {
    @Published var creditors: [Duty] = []
    @Published var debtors: [Duty] = []
    
    private let repository: T
    
    init(repository: T) {
        self.repository = repository
        reload()
    }
    
    func reload() {
        let duties = repository.readAll()
        self.creditors = duties.filter({ $0.person.role == .creditor })
        self.debtors = duties.filter({ $0.person.role == .debtor })
    }
    
    func addDuty(amount: String, name: String, role: Person.Role) {
        let person = Person(name: name, role: role)
        let duty = Duty(id: UUID(), amount: Double(amount) ?? 0, person: person)
        
        try? repository.create(entity: duty)
        reload()
    }
    
    func deleteDuty(at offsets: IndexSet, role: Person.Role) {
        let index = offsets.first!
        let deletingEntity = role == .creditor ? creditors[index] : debtors[index]
            
        try? repository.delete(entity: deletingEntity)
        
        reload()
    }
}
