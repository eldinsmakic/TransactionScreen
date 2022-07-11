//
//  FilterButton.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 06/07/2022.
//

import SwiftUI

struct FilterButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        HStack(alignment: .top) {

            Button {
                action()
            } label: {
                Image(systemName: "slider.vertical.3")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("Filter")
            }.padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 5)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(15)
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var action: () -> Void = { print("hh ") }
    static var previews: some View {
        FilterButton(action: action)
    }
}
