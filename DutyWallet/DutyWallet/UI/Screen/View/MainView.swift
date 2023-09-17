//
//  MainView.swift
//  DutyWallet
//
//  Created by Иван Вдовин on 14.09.2023.
//

import SwiftUI

struct MainView: View { 
    @StateObject var mainVM = MainVewModel(repository: RealmRepository<Duty>())
    @State private var addAlert = false
    
    struct CreditDutyView: View {
        var duties: [Duty]
        
        @State private var name = ""
        @State private var amount = ""
        var role: Person.Role
        var deleteCell: (IndexSet, Person.Role) -> ()
        var add: (String, String, Person.Role) -> ()
        @Binding var alert: Bool
        
        var body: some View {
            List {
                ForEach(duties, id: \.id) { duty in
                    NavigationLink(destination: {
                        DetailDutyView()
                    }, label: {
                        HStack {
                            Image(systemName: "person.fill")
                            Text(duty.person.name)
                            Spacer()
                            Image(systemName: "rublesign")
                            Text(duty.amount.description)
                        }
                    })
                    .padding()
                }
                .onDelete { indexSet in
                    deleteCell(indexSet, role)
                }
            }
            .alert("Новый долг",
                   isPresented: $alert,
                   actions: {
                TextField(role == .creditor ? "Кто мне будет должен" : "Кому я буду должен", text: $name)
                    TextField("Сумма", text: $amount)
#if os(iOS)
                        .keyboardType(.numberPad)
#endif
                    Button("Добавить", action: {
                        add(amount, name, role)
                        name = ""; amount = ""
                    })
                Button("Отмена", role: .cancel, action: { name = ""; amount = "" })
                }
            )
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                CreditDutyView(duties: mainVM.creditors, role: .creditor, deleteCell: mainVM.deleteDuty, add: mainVM.addDuty, alert: $addAlert)
                .tabItem {
                    Image(systemName: "square.and.arrow.down")
                    Text("Мне должны")
                }
                
                CreditDutyView(duties: mainVM.debtors, role: .debtor, deleteCell: mainVM.deleteDuty, add: mainVM.addDuty, alert: $addAlert)
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Я должен")
                }
            }
            .navigationTitle("Duty Wallet")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        addAlert = true
                    }, label: {
                        Image(systemName: "person.fill.badge.plus")
                    })
                }
            }
        }
    }
}

//                Group {
//                    List {
//                        ForEach(mainVM.debtors, id: \.id) { duty in
//                            NavigationLink(destination: {
//                                DetailDutyView()
//                            }, label: {
//                                HStack {
//                                    Image(systemName: "person.fill")
//                                    Text(duty.person.name)
//                                    Spacer()
//                                    Image(systemName: "rublesign")
//                                    Text(duty.amount.description)
//                                }
//                            })
//                            .padding()
//                        }
//                        .onDelete { indexSet in
//                            mainVM.deleteDuty(at: indexSet, inCreditors: false)
//                        }
//                    }
//                    .alert("Новый кредит",
//                           isPresented: $alert,
//                           actions: {
//                            TextField("Кому я буду должен", text: $name)
//                            TextField("Сумма", text: $amount)
//                            #if os(iOS)
//                                .keyboardType(.numberPad)
//                            #endif
//                            Button("Добавить", action: {
//                                mainVM.addDuty(amount: amount, name: name, role: .debtor)
//                                name = ""; amount = ""
//                            })
//                            Button("Отмена", role: .cancel, action: { name = ""; amount = "" })
//                        }
//                    )
//                }

#Preview {
    MainView()
}
