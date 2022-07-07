//
//  TransactionAddNewModal.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 20/11/2021.
//

import SwiftUI
import BudgetPlannerCore

struct TransactionAddNewModal: View {
    @State var title: String = ""
    @State var description: String = ""
    @State var amount: Decimal?
    @State var date = Date()
    @State var categorie: CategorieDTO?
    
    @Binding var isModalActivated: Bool

    @ObservedObject var presenter: TransactionPresenter

    var body: some View {
        VStack(alignment: .center) {
            TextField("Title", text: $title)
                    .multilineTextAlignment(.center)
            TextField("Description", text: $description)
                .multilineTextAlignment(.center)
            CategoriesMenu(selectedElement: $categorie)
            HStack {
                Spacer()
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                Spacer()
            }
            TextField(value: $amount, format: .number, prompt: nil, label: {
                Text("Montant")
            }).multilineTextAlignment(.center)
                
            Button {
                guard !title.isEmpty,
                      let amount = amount,
                      let categorie = categorie else {
                    return
                }

                let transaction = TransactionDTO(
                    title: title,
                    with: amount,
                    onDate: date,
                    withCategorie: categorie,
                    description: description
                )
                presenter.add(transaction)
                isModalActivated = false
            } label: {
                Text("Validate")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(.purple)
                    .cornerRadius(15)
            }
        }
    }
}

struct TransactionAddNewModal_Previews: PreviewProvider {
    @State static var isModalActivated = false
    @State static var presenter = TransactionPresenter()
    static var previews: some View {
        TransactionAddNewModal(isModalActivated: $isModalActivated, presenter: presenter)
    }
}
