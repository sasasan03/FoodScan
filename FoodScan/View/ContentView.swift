//
//  ContentView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/06.
//

import SwiftUI

struct ContentView: View {
    
    let client = OpenFoodFactsApiClient()
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text(text == "" ? "検索してください" : text)
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
            Button("検索") { }
        }
        .task {
            do  {
                _ = try await client.searchFood(itemName: "ケーキ")
            } catch {
                print("💫error",error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
