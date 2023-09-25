//
//  DetailDutyView.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 16.09.2023.
//

import SwiftUI

struct DetailDutyView: View {
    @StateObject var dutyVM = DetailDutyViewModel(dutiesRepository: RealmRepository<Duty>())
    var duty: Duty

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(duty.person.name) –" + " \(duty.person.role.title) "
                     + "вот столько:" + " \(duty.amount.description)" + "р")
                Button("чекнуть") {
                    dutyVM.reload()
                }
                Button("add history") { }
            }
            .padding()
            List {
                ForEach(duty.historyList) { history in
                    HStack {
                        Text(history.value.description)
                        Text(history.info)
                    }
                }
            }
            .navigationTitle("Долг")
        }
        .onAppear {
            dutyVM.duty = self.duty
        }
    }
}

#Preview {
    DetailDutyView(duty:
        Duty(
            id: UUID(),
            amount: 153,
            person:
                Person(name: "Ivan", role: .creditor),
            historyList: [
                History(id: UUID(), value: 64, info: "Куипл говно"),
                History(id: UUID(), value: 2635, info: "DIMA")
            ]
        )
    )
}
