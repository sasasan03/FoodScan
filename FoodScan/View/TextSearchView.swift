//
//  TextSearchView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct TextSearchView: View {
    
    @EnvironmentObject var router: Router
    @FocusState private var isSearchFocused: Bool
    @StateObject private var viewModel = TextSearchViewModel()
    
    var body: some View {
        Group {
            if !viewModel.isLoading {
                if let foods = viewModel.foods {
                    if !foods.isEmpty {
                        List {
                            ForEach(foods, id: \.self) { food in
                                Text(food.productName ?? "--商品名を取得できませんでした--")
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        router.push(.searchResult)
                                    }
                            }
                        }
                    } else {
                        Text("検索した食品が見つかりませんでした")
                    }
                } else {
                    Text("食品を検索してください")
                }
            } else {
                ProgressView()
            }
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "食品名を入力"
        )
        .searchFocused($isSearchFocused)
        .onSubmit(of: .search) {
            viewModel.searchFood()
        }
    }
}

#Preview {
    let router = Router()
    TextSearchView()
        .environmentObject(router)
}
