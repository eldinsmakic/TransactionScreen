//
//  TransactionScreenApp.swift
//  TransactionScreen
//
//  Created by Eldin SMAKIC on 26/06/2022.
//

import Foundation
import SwiftUI

@main
struct testApp: App {
    let injection = InjectionInit()
    var body: some Scene {
        WindowGroup {
            TransationsView()
        }
    }
}
