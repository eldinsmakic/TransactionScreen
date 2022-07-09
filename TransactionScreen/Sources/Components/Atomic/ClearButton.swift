//
//  ClearButton.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 06/07/2022.
//

import SwiftUI

struct ClearButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "x.circle")
                .foregroundColor(.white)
                .background(.red)
                .clipShape(Circle())
        }
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton {
            print("hh")
        }
    }
}
