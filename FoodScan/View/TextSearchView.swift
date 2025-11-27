//
//  TextSearchView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct TextSearchView: View {
    
    @EnvironmentObject var router: Router
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    @StateObject private var viewModel = TextSearchViewModel()
    let isSearchResult = true
    let foods:[OpenFoodFactsProduct] = DummyData().sampleProducts
    
    var body: some View {
        Group {
            if isSearchResult {
                List {
                    ForEach (foods, id: \.self) { food in
                        Text(food.productName ?? "-----")
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                router.push(.searchResult)
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
        .onSubmit(of: .search) {
            viewModel.searchFood(searchText)
        }
    }
}

#Preview {
    let router = Router()
    TextSearchView()
        .environmentObject(router)
}
