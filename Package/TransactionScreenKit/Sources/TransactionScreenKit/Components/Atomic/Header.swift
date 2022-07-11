//
//  Header.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 05/07/2022.
//

import SwiftUI

struct Header: View {
    let date: Date
    let amout: NSNumber

    var body: some View {
        HStack {
            Text(date.toFormatDate)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            Text("\(amout.formated)").foregroundColor(.gray)
        }
        
    }
}

extension NSNumber {
    var formated: String {
        let numberFormater = NumberFormatter()
        numberFormater.maximumFractionDigits = 2
        numberFormater.allowsFloats = true
        numberFormater.locale = Locale.current
        numberFormater.numberStyle = .currency
        numberFormater.usesGroupingSeparator = true

        return numberFormater.string(from: self) ?? ""
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(date: .now, amout: -22.0)
    }
}
