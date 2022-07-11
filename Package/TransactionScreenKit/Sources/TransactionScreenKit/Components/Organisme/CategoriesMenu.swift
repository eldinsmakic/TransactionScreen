//
//  CategoriesMenu.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 08/12/2021.
//

import SwiftUI
import BudgetPlannerCore

class CategeriesMenuPresenter: ObservableObject {
    @Injected var repository: AnyRepository<CategorieDTO>
    
    @Published public var list: [CategorieDTO] = []

    public init() {
        self.repository.model.assign(to: &self.$list)
    }

    public func add(categorie: CategorieDTO) {
        repository.add(categorie)
    }

    public func getCategories(ofType type: CategorieType) -> [CategorieDTO] {
        list.filter { categories in categories.type == type }
    }

    public func erase() {
        repository.erase()
    }

    public func fetch() {
        repository.fetch()
    }

    public func remove(categorie: CategorieDTO) {
        repository.remove(categorie)
    }
}

struct CategoriesMenu: View {
    
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
