//
//  File.swift
//  
//
//  Created by Eldin SMAKIC on 26/06/2022.
//

import Foundation
import Combine
import BudgetPlannerCore

class InjectionInit {
    init() {
        Injection.shared.removeAll()
        Injection.shared.register(CategorieLocalStorage.self) { _ in
            CategorieLocalStorage.shared
        }
        Injection.shared.register(CategorieRepository.self) { _ in
            CategorieRepository()
        }
        Injection.shared.register(TransactionLocalStorage.self) { _ in
            TransactionLocalStorage.shared
        }
        Injection.shared.register(TransactionRepository.self) { _ in
            TransactionRepository()
        }
        Injection.shared.register(AnyRepository<TransactionDTO>.self) { _ in
            AnyRepository<TransactionDTO>(MockTransactionRepository())
        }
    }
}

private let categorie = CategorieDTO(name: "Course", image: "img", type: .depense, color: .blue)

class MockTransactionRepository: RepositoryProtocol {
    var publisher = PassthroughSubject<[TransactionDTO], Never>()
    
    var values: [TransactionDTO] = [
        .init(with: 100, onDate: .now, withCategorie: categorie, description: "hello world"),
        .init(with: 10, onDate: .now, withCategorie: categorie, description: "hello world"),
        .init(with: 12, onDate: (Date() + 1.days.timeInterval), withCategorie: categorie, description: "hello world")
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
    
    func fetch() {
        publisher.send(values)
    }
    
    func erase() {
        values.removeAll()
        publisher.send(values)
    }
    
    func filterByDate() -> [String:[TransactionDTO]]  {
        [
            "12/01/2022" : [ .init(with: 100, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(with: 10, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(with: 10, onDate: .now, withCategorie: categorie, description: "hello world") ],
            "13/01/2022" : [ .init(with: 100, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(with: 10, onDate: .now, withCategorie: categorie, description: "hello world"),
                             .init(with: 10, onDate: .now, withCategorie: categorie, description: "hello world") ]
        ]
    }
}
