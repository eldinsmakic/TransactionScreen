//
//  TransactionPresenter.swift
//  BudgetPlanner (iOS)
//
//  Created by Eldin SMAKIC on 14/12/2021.
//

import Combine
import BudgetPlannerCore
import Foundation
import SwiftUI

class TransactionPresenter: ObservableObject {
    @Injected var repository: AnyRepository<TransactionDTO>

    @Published var list: [TransactionViewModel] = []

    init() {
        repository.model.map(self.mapToViewModel(list:)).assign(to: &$list)
    }

    func fetch () {
        repository.fetch()
    }

    func onDelete(at offsets: IndexSet) {
//        list.remove(atOffsets: <#T##IndexSet#>)
    }

    func mapToViewModel(list: [TransactionDTO]) -> [TransactionViewModel] {
        var compute: [String: [TransactionDTO]] = [:]
        let result :[TransactionViewModel]

        list.forEach { i in
            compute[i.date.toString()] = []
        }

        list.forEach { transaction in
            compute[transaction.date.toString()]?.append(transaction)
        }

        result = compute.map { (key: String, value: [TransactionDTO]) -> TransactionViewModel in
            let transactions = value.map { transaction in
                TransactionItemModel(
                    Title: transaction.title,
                    subtitle: transaction.description,
                    date: transaction.date,
                    amount: "\(transaction.montant) $",
                    amountColor: transaction.categorie.type == .depense ? Color.red : Color.green,
                    image: transaction.categorie.image,
                    imageColor: transaction.categorie.color.color
                )
            }

            return TransactionViewModel(date: transactions[0].date.toFormatDate, transactions: transactions)
        }
        
        return result
    }
}

extension Date {
    private var format: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMMd")
        return formatter
    }

    var toFormatDate: String {
        self.isToday ? "Today" : format.string(from: self)
    }
}

struct TransactionViewModel: Identifiable {
    var id = UUID()
    var date: String
    var transactions: [TransactionItemModel]
}

extension TransactionItemModel: Identifiable {
    public var id: UUID { UUID() }
}
