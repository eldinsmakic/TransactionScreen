//
//  CategoriesItem.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 28/11/2021.
//

import SwiftUI
import BudgetPlannerCore

struct CategoriesItem: View {
    let categorie: CategorieDTO
    
    var body: some View {
        HStack {
            Image(systemName: categorie.image)
                .resizable()
                .frame(width: 46, height: 46, alignment: .center)
                .padding(20)
                .foregroundColor(.white)
                .background(categorie.color.color)
                .clipShape(Circle())
            VStack {
                Text(categorie.name)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(categorie.type.name)
            }
            
        }
    }
}

struct CategoriesItem_Previews: PreviewProvider {
    @State static var categorie = CategorieDTO(name: "Essence", image: "car", type: .depense, color: .red)

    static var previews: some View {
        CategoriesItem(categorie: categorie)
    }
}
