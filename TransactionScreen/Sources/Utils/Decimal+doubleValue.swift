//
//  Decimal+doubleValue.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 10/07/2022.
//

import Foundation

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

