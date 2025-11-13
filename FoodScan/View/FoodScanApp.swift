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
    
    let api = OpenFoodFactsApiClient()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(router)
                .task {
                    do {
                        let aaa = try await api.searchFood(itemName: "コーラ")
                        print("---------------------")
                        print("フード：\(aaa)")
                    } catch {
                        print("---------------------")
                        print("\(error.localizedDescription)")
                        print("---------------------")
                    }
                }
        }
    }
}
