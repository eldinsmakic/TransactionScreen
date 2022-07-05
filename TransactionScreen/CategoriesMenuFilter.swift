//
//  CategorieMenuFilter.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 05/07/2022.
//

import SwiftUI
import Combine
import BudgetPlannerCore

struct CategoriesMenuFilter: View {
    
    @Binding var selectedElement: CategorieDTO?
    @State var isPresented = false
    @StateObject var presenter = CategeriesMenuPresenter()

    var body: some View {
        view(selectedElement: selectedElement)
            .onTapGesture {
                isPresented = true
            }
            .popover(isPresented: $isPresented) {
                ForEach(presenter.list) { categorie in
                    Button {
                        selectedElement = categorie
                        isPresented = false
                    } label: {
                        CategoriesItem(categorie: categorie)
                    }
                }.padding()
            }
            .onAppear {
                presenter.fetch()
            }
    }

    func view(selectedElement: CategorieDTO?) -> some View {
        VStack {
            if let selectedElement = selectedElement {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            self.selectedElement = nil
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(.white)
                                .background(.red)
                                .clipShape(Circle())
                        }
                    }
                    CategoriesItem(categorie: selectedElement, width: 16, height: 16)
                }.frame(width: 150, height: 40, alignment: .leading)
            } else {
                 Text("Select a categorie")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CategorieMenuFilter_Previews: PreviewProvider {
    @State static var value: CategorieDTO? = categorie

    static var previews: some View {
        CategoriesMenuFilter(selectedElement: $value)
    }
}
