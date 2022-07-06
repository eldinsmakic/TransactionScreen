//
//  DatesMenuFilter.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 06/07/2022.
//

import SwiftUI

struct DatesMenuFilter: View {
    @Binding var date: Date?
    @State private var value: Date = .now
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                DatePicker("", selection: $value, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .frame(width: 120)
                if let _ = date {
                    ClearButton {
                        self.date = nil
                    }
                }
                Spacer()
            }
        }.onChange(of: value) { newValue in
            date = newValue
        }
    }
}

struct DatesMenuFilter_Previews: PreviewProvider {
    @State static var date: Date?

    static var previews: some View {
        DatesMenuFilter(date: $date)
    }
}
