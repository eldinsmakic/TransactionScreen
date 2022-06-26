//
//  CategoriesMenu.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 08/12/2021.
//

import SwiftUI
import BudgetPlannerCore

struct CategoriesMenu: View {
    
    @Binding var selectedElement: CategorieDTO?
    @State var isPresented = false
    
    @StateObject var categorieManager = CategoriesManager()

    var body: some View {
        view(selectedElement: selectedElement)
            .onTapGesture {
                isPresented = true
            }
            .popover(isPresented: $isPresented) {
                ForEach(categorieManager.list) { categorie in
                    Button {
                        selectedElement = categorie
                        isPresented = false
                    } label: {
                        CategoriesItem(categorie: categorie)
                    }
                }.padding()
            }
            .onAppear {
                categorieManager.fetch()
            }
    }

    func view(selectedElement: CategorieDTO?) -> some View {
        VStack {
            if let selectedElement = selectedElement {
                 CategoriesItem(categorie: selectedElement)
            } else {
                 Text("Select a categorie")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CategoriesMenu_Previews: PreviewProvider {
    @State static var categorie: CategorieDTO? = nil
    static var previews: some View {
        CategoriesMenu(selectedElement: $categorie)
    }
}
