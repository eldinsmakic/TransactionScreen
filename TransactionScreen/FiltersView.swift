//
//  FiltersView.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 06/07/2022.
//

import SwiftUI
import Combine
import BudgetPlannerCore

struct FiltersView: View {
    @ObservedObject var presenter: TransactionPresenter
    @State private var filterByCategorie: CategorieDTO?
    @State private var filterByDate: Date?

    var body: some View {
        VStack {
            Text("Filters")
                .font(.title2)
                .fontWeight(.bold)
                .padding()

            HStack {
                Text("Categories")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Spacer()
            }
            CategoriesMenuFilter(selectedElement: $filterByCategorie)
            Divider()
            HStack {
                Text("Dates")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Spacer()
            }
            DatesMenuFilter(date: $filterByDate)
            Spacer()
        }
        .onChange(of: filterByCategorie) { newValue in
            guard let value = newValue else {
                presenter.removeFilter()
                return
            }

            presenter.filter(by: value)
        }.onChange(of: filterByDate, perform: { newValue in
            guard let value = newValue else {
                presenter.removeFilter()
                return
            }

            presenter.filter(by: value)
        })
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var injection = InjectionInit()
    static var previews: some View {
        FiltersView(presenter: .init())
    }
}
