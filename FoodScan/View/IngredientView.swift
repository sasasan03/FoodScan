//
//  Ingredient.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct IngredientView: View {
    
    let ingredients: String
    private var ingredientsList: [String] {
        ingredients.splitByComma()
    }
    
    var body: some View {
        if !ingredientsList.isEmpty {
            ScrollView {
                ForEach(ingredientsList, id: \.self) { ingredient in
                    VStack(alignment: .leading) {
                        Text(ingredient)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 3)
            }
        } else {
            Text("材料の情報がありません")
        }
        Spacer()
    }
}

#Preview {
    IngredientView(ingredients: "水、砂糖、レモン果汁")
}
