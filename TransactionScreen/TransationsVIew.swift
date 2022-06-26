//
//  TransationsVIew.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 20/11/2021.
//

import SwiftUI
import BudgetPlannerCore

struct TransationsView: View {
    @StateObject private var transactionPresenter = TransactionPresenter()
    @State var list: [TransactionViewModel] = []
    
    @State var isModalActivated = false
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Transactions")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            ForEach(list) { element in
                Section {
                    Text(element.date)
                        .font(.headline)
                }
                List {
                    ForEach(element.transactions) { transaction in
                        TransactionItem(
                            model: transaction
                        )
                    }.onDelete(perform: transactionPresenter.onDelete(at:))
                }.listStyle(.inset)
            }
        }.toolbar(content: {
            EditButton()
        })
            .padding(.top, 40)
            .padding(.horizontal)
            .sheet(
                isPresented: $isModalActivated,
                onDismiss: {}
            ) {
                TransactionAddNewModal(isModalActivated: $isModalActivated)
                    .background(.white)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            .onAppear(perform: {
                transactionPresenter.fetch()
            })
            .onReceive(self.transactionPresenter.$list, perform: { values in
                self.list = values
            })
            .addAddButton {
                self.isModalActivated = true
            }
    }
}

struct TransationsVIew_Previews: PreviewProvider {
    static var injection = InjectionInit()
    static var previews: some View {
        TransationsView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
