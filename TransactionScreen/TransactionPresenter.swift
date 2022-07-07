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
    @Published var dto: [TransactionDTO] = []

    var cancelable = Set<AnyCancellable>() 

    init() {
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

            let negatif = value.filter { $0.categorie.type == .depense }.map(\.montant)
            let positif = value.filter { $0.categorie.type == .revenue }.map(\.montant)
            let total = negatif.reduce(0,-) + positif.reduce(0,+)

            return TransactionViewModel(date: transactions[0].date, total: NSNumber(value: total.doubleValue) , transactions: transactions)
        }

        return result.sorted { transactionOne, transactionTwo in
            transactionOne.date < transactionTwo.date
        }
    }
}

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
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
    var total: NSNumber
    var transactions: [TransactionItemModel]
}

extension TransactionItemModel: Identifiable {
    public var id: UUID { UUID() }
}
