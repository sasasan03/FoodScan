//
//  FoodScanApp.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/06.
//

import SwiftUI

@main
struct FoodScanApp: App {
    
    @State private var router: Router = .init()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
        }
    }
}
