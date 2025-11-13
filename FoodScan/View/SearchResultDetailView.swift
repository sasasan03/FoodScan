//
//  searchResultDetailView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct ItemDetail: Identifiable {
    let id = UUID()
    let itemName: String
    let itemDetail: String
}

struct SearchResultDetailView: View {
    
    let isComponentAnalysis: Bool = false
    let items: [String]?
    let title: String
    
    var body: some View {
        
        if isComponentAnalysis { //成分分析
            ComponentAnalysisView()
                .navigationTitle("成分分析")
        } else {
            AdditivesAndIngredientsView(items: items)
                .navigationTitle(title)
        }
    }
    
}

struct AdditivesAndIngredientsView: View {
    let items: [String]?
    var body: some View {
        if let items {
            ForEach(items, id: \.self) { item in
                VStack(alignment: .leading) {
                    Text(item)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 3)
            Spacer()
        } else {
            Text("アイテムの取得に失敗しました")
        }
    }
}

struct ComponentAnalysisView: View {
    
    let itemDetails: [ItemDetail] = [
        ItemDetail(itemName: "パーム油不使用", itemDetail: "パーム油を含む成分は抽出されませんでした"),
        ItemDetail(itemName: "ビーガン", itemDetail: "非ビーガン成分不使用"),
        ItemDetail(itemName: "ベジタリアン", itemDetail: "ベジタリアン成分は抽出されませんでした")
    ]
    
    var body: some View {
        ForEach(itemDetails) { itemDetail in
            VStack(alignment: .leading) {
                Text(itemDetail.itemName)
                Text(itemDetail.itemDetail)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
        Spacer()
    }
}

#Preview {
    SearchResultDetailView(items: ["プレーンキャラメル","スクラロース","アセスルファムK"], title: "添加物")
}
