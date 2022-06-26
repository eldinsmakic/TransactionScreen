//
//  AddButton.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 28/11/2021.
//

import SwiftUI

struct AddButton: ViewModifier {
    var action: () -> Void

    func body(content: Content) -> some View {
        ZStack() {
            content
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()

                    Button(
                        action: action,
                        label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                        }
                    ).padding([.trailing, .bottom], 20)
                }
            }
        }
    }
}

extension View {
    func addAddButton(withAction action: @escaping () -> Void ) -> some View {
        modifier(AddButton(action: action))
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        TransationsView()
            .modifier(AddButton(action: { print("hello")}))
    }
}

