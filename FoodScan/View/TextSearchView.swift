//
//  TextSearchView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct TextSearchView: View {
    
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    let isSearchResult = true
    let foods: [String] = ["コーラ","ゼロコーラ","オリジナルコーラ"]
    
    var body: some View {
        Group {
            if isSearchResult {
                List {
                    ForEach (foods, id: \.self) { food in
                        NavigationLink(food) {
                            SearchResultView()
                                .navigationTitle(food)
                        }
                    }
                }
            } else {
                Text("食品を検索してください")
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "食品名を入力"
        )
        .searchFocused($isSearchFocused)
    }
}

#Preview {
    TextSearchView()
}
