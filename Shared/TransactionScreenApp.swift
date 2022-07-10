//
//  TransactionScreenApp.swift
//  Shared
//
//  Created by Eldin SMAKIC on 10/07/2022.
//
import Foundation
import SwiftUI
import TransactionScreenLib

@main
struct testApp: App {
    let injection = InjectionInit()
    var body: some Scene {
        WindowGroup {
            MainView(ViewModel())
        }
    }
}
