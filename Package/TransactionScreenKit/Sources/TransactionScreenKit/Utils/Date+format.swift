//
//  Date+format.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 10/07/2022.
//

import Foundation

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
