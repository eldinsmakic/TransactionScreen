//
//  TransationsVIew.swift
//  BudgetPlanner (iOS)
//
//  Created by S858071 on 20/11/2021.
//

import SwiftUI
import BudgetPlannerCore

public struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    
    public init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
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
                    ForEach(viewModel.list) { element in
                        Section(content: {
                            ForEach(element.transactions) { transaction in
                                TransactionItem(
                                    model: transaction
                                )
                            }.onDelete(perform: viewModel.onDelete(at:))
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
                FiltersView(viewModel: viewModel, isPresented: $isFilterViewPresented).padding()
            }
            .sheet(
                isPresented: $isModalActivated,
                onDismiss: {}
            ) {
                TransactionAddNewModal(isModalActivated: $isModalActivated, viewModel: viewModel)
                    .background(.white)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            .onAppear{
                viewModel.fetch()
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
        MainView(.init())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
