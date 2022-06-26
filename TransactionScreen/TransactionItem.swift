//
//  TransactionItem.swift
//  BudgetPlanner
//
//  Created by S858071 on 15/11/2021.
//

import SwiftUI

struct TransactionItemModel {
    let Title: String
    let subtitle: String
    let date: Date
    let amount: String
    let image: String
    let amountColor: Color
}

struct TransactionItem: View {
    let model: TransactionItemModel

    var body: some View {
        HStack {
            Image(model.image)
                .resizable()
                .frame(width: 36, height: 36)
            VStack(alignment: .leading) {
                HStack {
                    Text(model.Title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text(model.amount)
                        .font(.subheadline)
                        .foregroundColor(model.amountColor)
                }
                Text(model.subtitle)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct TransactionItem_Previews: PreviewProvider {
    static let model = TransactionItemModel(
        Title: "Pizza Hut",
        subtitle: "Anne anniversary",
        date: Date(),
        amount: "-30$",
        image: "exampleTransaction",
        amountColor: Color.red
    )

    static var previews: some View {
        Group {
            TransactionItem(model: model)
            TransactionItem(model: model)
.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
