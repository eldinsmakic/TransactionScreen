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
        Injection.shared.register(AnyRepository<CategorieDTO>.self) { _ in
            AnyRepository<CategorieDTO>(MockCategoryRepository())
        }
        Injection.shared.register(AnyRepository<TransactionDTO>.self) { _ in
            AnyRepository<TransactionDTO>(MockTransactionRepository())
        }
    }
}

let categorie = CategorieDTO(name: "Course", image: "star.fill", type: .depense, color: .blue)
let categorie2 = CategorieDTO(name: "Car", image: "car", type: .depense, color: .red)
let categorie3 = CategorieDTO(name: "Freelance", image: "creditcard.fill", type: .revenue, color: .green)


