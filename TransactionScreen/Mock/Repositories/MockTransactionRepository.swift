//
//  MockTransactionRepository.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 27/06/2022.
//

import Foundation
import Combine
import BudgetPlannerCore

class MockTransactionRepository: RepositoryProtocol {
  
    var publisher = PassthroughSubject<[TransactionDTO], Never>()
    
    var values: [TransactionDTO] = [
        .init(title: "Pizza Hut", with: 100, onDate: .now, withCategorie: categorie, description: "Plaisir du mardi"),
        .init(title: "Auchan", with: 10, onDate: .now, withCategorie: categorie, description: "Course du mecredi"),
        .init(title: "Essence", with: 12, onDate: (Date() + 1.days.timeInterval), withCategorie: categorie, description: "Plein du mois"),
        .init(title: "Salaire", with: 1200, onDate: (Date() + 1.days.timeInterval), withCategorie: categorie3, description: ""),
        .init(title: "Voiture", with: 300, onDate: (Date() - 3.days.timeInterval), withCategorie: categorie2, description: "")
    ]

    public init() {}

    var model: AnyPublisher<[TransactionDTO], Never> { publisher.eraseToAnyPublisher() }
    
    func add(_ value: TransactionDTO) {
        values.append(value)
        publisher.send(values)
    }
    
    func remove(_ value: TransactionDTO) {
        values.removeAll { v in
            v == value
        }
        publisher.send(values)
    }
    
    func delete(at offsets: IndexSet) {
        values.remove(atOffsets: offsets)
        publisher.send(values)
    }
    
    func fetch() {
        publisher.send(values)
    }
    
    func erase() {
        values.removeAll()
        publisher.send(values)
    }
    
    func filterByDate() -> [String:[TransactionDTO]]  {
        [
            "12/01/2022" : [ .init(title: "", with: 100, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(title: "", with: 10, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(title: "", with: 10, onDate: .now, withCategorie: categorie, description: "hello world") ],
            "13/01/2022" : [ .init(title: "", with: 100, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(title: "", with: 10, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(title: "", with: 10, onDate: .now, withCategorie: categorie, description: "hello world") ]
        ]
    }
}
