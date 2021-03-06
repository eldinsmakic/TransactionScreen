//
//  TransactionItem.swift
//  BudgetPlanner
//
//  Created by S858071 on 15/11/2021.
//

import SwiftUI


struct TransactionItem: View {
    let model: Transaction

    var body: some View {
        HStack {
            Image(systemName: model.image)
                .resizable()
                .frame(width: 36, height: 36)
                .padding(14)
                .foregroundColor(.white)
                .background(model.imageColor)
                .clipShape(Circle())
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
    static let model = Transaction(
        Title: "Pizza Hut",
        subtitle: "Anne anniversary",
        date: Date(),
        amount: "-30$",
        amountColor: Color.red,
        image: "star.fill",
        imageColor: Color.indigo
    )

    static var previews: some View {
        Group {
            TransactionItem(model: model)
            TransactionItem(model: model)
        }
    }
}
