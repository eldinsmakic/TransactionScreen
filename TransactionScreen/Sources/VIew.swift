//
//  TransationsVIew.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 20/11/2021.
//

import SwiftUI
import BudgetPlannerCore

public struct MainView: View {
    @ObservedObject var presenter: Presenter
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }

    @State private var isModalActivated = false
    @State private var editMode = EditMode.inactive
    @State private var isFilterViewPresented = false
    
    public var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Transactions")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
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
                isPresented: $isFilterViewPresented,
                onDismiss: {}
            ) {
                FiltersView(presenter: presenter, isPresented: $isFilterViewPresented).padding()
            }
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
            HStack {
                Spacer()
                FilterButton {
                    isFilterViewPresented = true
                }.padding(.trailing)
            }
        }
    }
}

struct TransationsVIew_Previews: PreviewProvider {
//    static var injection = InjectionInit()
    static var previews: some View {
        MainView(presenter: .init())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
