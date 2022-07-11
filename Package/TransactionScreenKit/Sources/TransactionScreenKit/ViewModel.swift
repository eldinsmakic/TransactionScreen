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

public final class ViewModel: ObservableObject {
    @Injected var repository: AnyRepository<TransactionDTO>

    @Published var list: [Model] = []
    @Published var dto: [TransactionDTO] = []

    var cancelable = Set<AnyCancellable>() 

    public init() {
        repository.model.map(self.mapToViewModel(list:)).assign(to: &$list)
        repository.model.assign(to: &$dto)
    }

    func fetch () {
        repository.fetch()
    }
    
    func removeFilter() {
        self.list = mapToViewModel(list: dto)
    }

    func applyFilter(_ categorie: CategorieDTO? = nil, _ date: Date?, _ amount: Decimal?) {
        var result: [TransactionDTO] = dto
        
        if let categorie = categorie {
            result = result.filter(by: categorie)
        }

        if let date = date {
            result = result.filter(by: date)
        }

        if let amount = amount {
            result = result.filter(by: amount)
        }

        list = mapToViewModel(list: result)
    }

    func add(_ dto: TransactionDTO) {
        repository.add(dto)
    }

    func onDelete(at offsets: IndexSet) {
        repository.delete(offsets)
    }

    func mapToViewModel(list: [TransactionDTO]) -> [Model] {
        var compute: [String: [TransactionDTO]] = [:]
        let result: [Model]

        list.forEach { i in
            compute[i.date.toKey] = []
        }

        list.forEach { transaction in
            compute[transaction.date.toKey]?.append(transaction)
        }

        result = compute.map { (key: String, value: [TransactionDTO]) -> Model in
            let transactions = value.map { transaction in
                Transaction(
                    Title: transaction.title,
                    subtitle: transaction.description,
                    date: transaction.date,
                    amount: "\(transaction.montant) $",
                    amountColor: transaction.categorie.type == .depense ? Color.red : Color.green,
                    image: transaction.categorie.image,
                    imageColor: transaction.categorie.color.color
                )
            }

            let negatif = value.filter { $0.categorie.type == .depense }.map(\.montant)
            let positif = value.filter { $0.categorie.type == .revenue }.map(\.montant)
            let total = negatif.reduce(0,-) + positif.reduce(0,+)

            return Model(date: transactions[0].date, total: NSNumber(value: total.doubleValue) , transactions: transactions)
        }

        return result.sorted { transactionOne, transactionTwo in
            transactionOne.date < transactionTwo.date
        }
    }
}
