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
            palmOilFreeView
            Divider()
            veganView
            Divider()
            vegetarianView
            Divider()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
        Spacer()
    }
    
    var palmOilFreeView: some View {
        Group {
            Text("パーム油不使用")
            Text("パーム油を含む成分は抽出されませんでした")
        }
    }
    
    var veganView: some View {
        Group {
            Text("ビーガン")
            Text("非ビーガン成分不使用")
        }
    }
    
    var vegetarianView: some View {
        Group {
            Text("ベジタリアン")
            Text("ベジタリアン成分は抽出されませんでした")
        }
    }
}

private extension ComponentAnalysisView {
    
    func aaaa(xxx: [String]) {
        xxx.forEach { x in
            
        }
    }
    
    func containsPositiveTag(_  ingredient: String) -> Bool {
        if ingredient.contains("en:palm-oil-free") {
            return true
        }
        if ingredient.contains("en:maybe-vegan") {
            return true
        }
        if ingredient.contains("en:maybe-vegetarian") {
            return true
        }
        return false
    }
}

#Preview {
    ComponentAnalysisView(ingredientsAnalysis: [""])
}
