//
//  MainViewModel.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 15.09.2023.
//

import Foundation
import SwiftUI

class MainViewModel<T>: ObservableObject where T.Entity == Duty, T: RepositoryProtocol {
    @Published var creditors = [Duty]()
    @Published var debtors = [Duty]()
    
    @Published var currentHistory = [History]()
    
    private let repository: T
    
    init(repository: T) {
        self.repository = repository
        reload()
    }
    
    func reload() {
        let duties = repository.readAll()
        
        for duty in duties {
            if duty.person.role == .creditor {
                self.creditors.append(duty)
            } else {
                self.debtors.append(duty)
            }
        }
    }
    
    func addDuty(amount: String, name: String, role: Person.Role) {
        let person = Person(name: name, role: role)
        let duty = Duty(id: UUID(), amount: Double(amount) ?? 0, person: person, historyList: [])
        
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
