//
//  FoodScanApp.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/06.
//

import SwiftUI

@main
struct FoodScanApp: App {
    
    @StateObject private var router: Router = .init()
    private let apiClient = OpenFoodFactsApiClient()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
        }
    }
}
