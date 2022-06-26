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
    @State var amount: Decimal?
    @State var date = Date()
    @State var categorie: CategorieDTO?
    
    @Binding var isModalActivated: Bool
    
    private let transactionManager = TransactionManager()
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("Label", text: $title)
                    .multilineTextAlignment(.center)
            CategoriesMenu(selectedElement: $categorie)
            HStack {
                Spacer()
                DatePicker("Date", selection: $date)
                    .datePickerStyle(.graphical)
                Spacer()
            }
            TextField(value: $amount, format: .number, prompt: nil, label: {
                Text("Montant")
            }).multilineTextAlignment(.center)
                
            Button {
                let transaction = TransactionDTO(
                    with: amount ?? 0, onDate: date, withCategorie: categorie!, description: title)
                transactionManager.add(transaction: transaction)
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
    static var previews: some View {
        TransactionAddNewModal(isModalActivated: $isModalActivated)
    }
}
