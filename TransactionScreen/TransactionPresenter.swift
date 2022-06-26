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
    private let transactionManager = TransactionManager()

    @Published var list: [TransactionViewModel] = []

    init() {
        repository.model.map(self.mapToViewModel(list:)).assign(to: &$list)
    }

    func fetch () {
        repository.fetch()
        transactionManager.fetch()
    }

    func onDelete(at offsets: IndexSet) {
//        let transaction = list[offsets.first!]
        let transaction = transactionManager.list[offsets.first!]
        repository.remove(transaction)
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
                    Title: transaction.description!,
                    subtitle: transaction.description!,
                    date: transaction.date,
                    amount: "\(transaction.montant)",
                    image: transaction.categorie.image,
                    amountColor: transaction.categorie.color.color
                )
            }

            return TransactionViewModel(date: key, transactions: transactions)
        }
        
        return result
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
