//
//  TransationsVIew.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 20/11/2021.
//

import SwiftUI
import BudgetPlannerCore

struct TransationsView: View {
    @ObservedObject var presenter: TransactionPresenter

    @State private var isModalActivated = false
    @State private var editMode = EditMode.inactive
    @State private var filterByCategorie: CategorieDTO?
    @State private var filterByDate: Date? = .now
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Transactions")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            VStack {
                Text("Filters")
                    .font(.title2)
                HStack {
                    VStack {
                        Text("by Categories")
                        CategoriesMenuFilter(selectedElement: $filterByCategorie)
                    }
                    VStack {
                        Text("by Date")
                        DatesMenuFilter(date: $filterByDate)
                    }
                }
            }.onChange(of: filterByCategorie) { newValue in
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
            .padding()
            List {
                ForEach(presenter.list) { element in
                    Section(content: {
                        ForEach(element.transactions) { transaction in
                            TransactionItem(
                                model: transaction
                            )
                        }.onDelete(perform: presenter.onDelete(at:))
                    }, header: {
                        Header(date: element.date, amout: element.total)
                    })
                }
            }
        }.toolbar(content: {
            EditButton()
        })
            .padding(.top, 40)
            .padding(.horizontal)
            .sheet(
                isPresented: $isModalActivated,
                onDismiss: {}
            ) {
                TransactionAddNewModal(isModalActivated: $isModalActivated, presenter: presenter)
                    .background(.white)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            .onAppear{
                presenter.fetch()
                        // Set the default to clear
                UITableView.appearance().backgroundColor = .clear
            }
            .addAddButton {
                self.isModalActivated = true
            }
    }
}

struct TransationsVIew_Previews: PreviewProvider {
    static var injection = InjectionInit()
    static var previews: some View {
        TransationsView(presenter: .init())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
