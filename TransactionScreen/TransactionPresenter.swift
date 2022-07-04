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

final class TransactionPresenter: ObservableObject {
    @Injected var repository: AnyRepository<TransactionDTO>

    @Published var list: [TransactionViewModel] = []

    var cancelable = Set<AnyCancellable>() 

    init() {
        repository.model.map(self.mapToViewModel(list:)).assign(to: &$list)
    }

    func fetch () {
        repository.fetch()
    }

    func add(_ dto: TransactionDTO) {
        repository.add(dto)
    }

    func onDelete(at offsets: IndexSet) {
        repository.delete(offsets)
    }

    func mapToViewModel(list: [TransactionDTO]) -> [TransactionViewModel] {
        var compute: [String: [TransactionDTO]] = [:]
        let result :[TransactionViewModel]

        list.forEach { i in
            compute[i.date.toKey] = []
        }

        list.forEach { transaction in
            compute[transaction.date.toKey]?.append(transaction)
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

            return TransactionViewModel(date: transactions[0].date, transactions: transactions)
        }

        return result.sorted { transactionOne, transactionTwo in
            transactionOne.date < transactionTwo.date
        }
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

    var toKey: String {
//        format.setLocalizedDateFormatFromTemplate("DD/MM/YY")
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd/MM/YY"
        return formatter.string(from: self)
    }
}

struct TransactionViewModel: Identifiable {
    var id = UUID()
    var date: Date
    var transactions: [TransactionItemModel]
}

extension TransactionItemModel: Identifiable {
    public var id: UUID { UUID() }
}
