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
        Group {
            if containPalmOil(ingredientsAnalysis) {
                Text("パーム油不使用")
                Text("パーム油を含む成分は抽出されませんでした")
                    .foregroundStyle(Color.gray)
            } else {
                Text("パーム油使用")
                Text("パーム油を含む成分が抽出されました")
                    .foregroundStyle(Color.red)
            }
        }
    }
    
    private var vegan: some View {
        Group {
            Text("ビーガン")
            if containMaybeVegan(ingredientsAnalysis) {
                Text("非ビーガン成分不使用")
                    .foregroundStyle(Color.gray)
            } else {
                Text("非ビーガン成分使用")
                    .foregroundStyle(Color.red)
            }
        }
    }
    
    private var vegetarian: some View {
        Group {
            Text("ベジタリアン")
            if containMaybeVegetarian(ingredientsAnalysis) {
                Text("ベジタリアン成分は抽出されませんでした")
                    .foregroundStyle(Color.gray)
            } else {
                Text("ベジタリアン成分が抽出されました")
                    .foregroundStyle(Color.red)
            }
        }
    }
}

private extension ComponentAnalysisView {
    
    func containPalmOil(_  ingredients: [String]) -> Bool {
        if ingredients.contains("en:palm-oil") {
            return true
        }
        return false
    }
    
    func containMaybeVegan(_  ingredients: [String]) -> Bool {
        if ingredients.contains("en:maybe-vegan") {
            return true
        }
        return false
    }
    
    func containMaybeVegetarian(_  ingredients: [String]) -> Bool {
        if ingredients.contains("en:maybe-vegetarian") {
            return true
        }
        return false
    }
}

#Preview {
    ComponentAnalysisView(ingredientsAnalysis: [""])
}
