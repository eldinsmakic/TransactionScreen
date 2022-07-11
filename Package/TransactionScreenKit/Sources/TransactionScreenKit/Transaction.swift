//
//  Transaction.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 10/07/2022.
//

import Foundation
import SwiftUI

struct Transaction {
    let Title: String
    let subtitle: String
    let date: Date
    let amount: String
    let amountColor: Color
    let image: String
    let imageColor: Color
}

extension Transaction: Identifiable {
    public var id: UUID { UUID() }
}
