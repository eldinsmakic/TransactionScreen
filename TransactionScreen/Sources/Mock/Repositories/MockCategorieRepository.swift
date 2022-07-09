//
//  MockCategorieRepository.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 27/06/2022.
//

import Foundation
import Combine
import BudgetPlannerCore

class MockCategoryRepository: RepositoryProtocol {
    var publisher = PassthroughSubject<[CategorieDTO], Never>()
    
    var values: [CategorieDTO] = [
        categorie,
        categorie2,
        categorie3
    ]

    public init() {}

    var model: AnyPublisher<[CategorieDTO], Never> { publisher.eraseToAnyPublisher() }
    
    func add(_ value: CategorieDTO) {
        values.append(value)
        publisher.send(values)
    }
    
    func remove(_ value: CategorieDTO) {
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
}
