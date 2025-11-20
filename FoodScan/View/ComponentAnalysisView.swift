//
//  ComponentAnalysisView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct ItemDetail: Identifiable {
    let id  = UUID()
    let itemName: String
    let itemDetail: String
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
    ComponentAnalysisView()
}
