//
//  Model.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 10/07/2022.
//

import Foundation

struct Model: Identifiable {
    var id = UUID()
    var date: Date
    var total: NSNumber
    var transactions: [Transaction]
}
