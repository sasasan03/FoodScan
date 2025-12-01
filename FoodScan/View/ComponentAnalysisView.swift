//
//  ComponentAnalysisView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct ComponentAnalysisView: View {
    
    let ingredientsAnalysis: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            palmOilFree
            Divider()
            vegan
            Divider()
            vegetarian
            Divider()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
        Spacer()
    }
    
    private var palmOilFree: some View {
        VStack(alignment: .leading) {
            Text("パーム油")
            Text(containPalmOil(ingredientsAnalysis))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var vegan: some View {
        VStack(alignment: .leading) {
            Text("ビーガン")
            Text(containVegan(ingredientsAnalysis))
                .foregroundStyle(Color.gray)
        }
    }
    
    private var vegetarian: some View {
        VStack(alignment: .leading) {
            Text("ベジタリアン")
            Text(containVegetarian(ingredientsAnalysis))
                .foregroundStyle(Color.gray)
        }
    }
}

private extension ComponentAnalysisView {

    func containPalmOil(_  ingredients: [String]) -> String {
        if ingredients.contains("en:palm-oil") {
            return "パーム油を含む成分が含まれています"
        }
        if ingredients.contains("en:palm-oil-free") {
            return "パーム油を含む成分は含まれていません"
        }
        return "パーム油を使用しているか不明です"
    }
    
    func containVegan(_  ingredients: [String]) -> String {
        if ingredients.contains("en:vegan") {
            return "ヴィーガン食品です"
        }
        if ingredients.contains("en:maybe-vegan") {
            return "ヴィーガン食品かもしれません"
        }
        if ingredients.contains("en:non-vegan") {
            return "ヴィーガン食品ではありません"
        }
        return "ヴィーガン食品かどうかは不明です"
    }
    
    func containVegetarian(_  ingredients: [String]) -> String {
        if ingredients.contains("en:vegetarian") {
            return "ベジタリアン食品です"
        }
        if ingredients.contains("en:maybe-vegetarian") {
            return "ベジタリアン食品かもしれません"
        }
        if ingredients.contains("en:non-vegetarian") {
            return "ベジタリアン食品ではありません"
        }
        return "ベジタリアン食品かどうかは不明です"
    }
}

#Preview {
    ComponentAnalysisView(ingredientsAnalysis: [""])
}
