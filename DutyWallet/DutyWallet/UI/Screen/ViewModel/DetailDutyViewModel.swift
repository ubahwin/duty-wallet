//
//  DetailDutyViewModel.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 18.09.2023.
//

import SwiftUI

class DetailDutyViewModel<T>: ObservableObject where T.Entity == Duty, T: RepositoryProtocol {
    @Published var duty: Duty?

    private let dutiesRepository: T

    init(dutiesRepository: T) {
        self.dutiesRepository = dutiesRepository
        reload()
    }

    func reload() {
        if let amount = duty?.amount {
            print(amount)
        }
    }
}
