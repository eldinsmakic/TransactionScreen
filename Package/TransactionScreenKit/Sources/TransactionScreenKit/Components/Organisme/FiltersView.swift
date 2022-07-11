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
    @ObservedObject var viewModel: ViewModel
    @Binding var isPresented: Bool

    @State private var filterByCategorie: CategorieDTO?
    @State private var filterByDate: Date?

    var body: some View {
        ZStack(alignment: .top) {
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

                Button {
                    viewModel.removeFilter()
                } label: {
                    Text("Clear")
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 200, height: 40)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(25)
                }
                
                Button {
                    viewModel.applyFilter(
                        filterByCategorie,
                        filterByDate,
                        nil
                    )
                } label: {
                    Text("Apply")
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 200, height: 40)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25)
                }
                .padding()
            }
            HStack {
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "x.square.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 32, height: 32)
                }.padding(.trailing)
            }
        }
//        .onChange(of: filterByCategorie) { newValue in
//            guard let value = newValue else {
//                return
//            }
//
//            presenter.filter(by: value)
//        }.onChange(of: filterByDate, perform: { newValue in
//            guard let value = newValue else {
//                return
//            }
//
//            presenter.filter(by: value)
//        })
    }
}

struct FiltersView_Previews: PreviewProvider {
//    static var injection = InjectionInit()
    @State static var isPresented = true

    static var previews: some View {
        FiltersView(viewModel: .init(), isPresented: $isPresented)
    }
}
