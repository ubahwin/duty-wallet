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

    private let dutiesRepository: T

    init(repository: T) {
        self.dutiesRepository = repository
        reload()
    }

    func reload() {
        var creditors = [Duty](), debtors = [Duty]()
        for duty in dutiesRepository.readAll() {
            switch duty.person.role {
            case .creditor:
                creditors.append(duty)
            case .debtor:
                debtors.append(duty)
            }
        }
        self.creditors = creditors
        self.debtors = debtors
    }

    func addDuty(amount: String, name: String, role: Person.Role) {
        let person = Person(name: name, role: role)
        let duty = Duty(id: UUID(), amount: Double(amount) ?? 0, person: person, historyList: [])

        try? dutiesRepository.create(entity: duty)
        reload()
    }

    func deleteDuty(at offsets: IndexSet, role: Person.Role) {
        let index = offsets.first!
        let deletingEntity = role == .creditor ? creditors[index] : debtors[index]

        try? dutiesRepository.delete(entity: deletingEntity)
        reload()
    }

    func delAll() {
        for duty in creditors {
            try? dutiesRepository.delete(entity: duty)
        }
        for duty in debtors {
            try? dutiesRepository.delete(entity: duty)
        }
    }
}
