//
//  DetailDutyView.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 16.09.2023.
//

import SwiftUI

struct DetailDutyView: View {
    @ObservedObject var mainVM: MainViewModel<RealmRepository<Duty>>
    var duty: Duty
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(duty.person.name) –" + " \(duty.person.role.title) " + "вот столько:" + " \(duty.amount.description)" + "р")
                Button("add") {
                    
                }
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
    }
}

#Preview {
    DetailDutyView(mainVM: MainViewModel(repository: RealmRepository<Duty>()), duty: Duty(id: UUID(), amount: 153, person: Person(name: "Ivan", role: .creditor), historyList: [History(id: UUID(), value: 64, info: "Куипл говно"), History(id: UUID(), value: 2635, info: "DIMA")]))
}
