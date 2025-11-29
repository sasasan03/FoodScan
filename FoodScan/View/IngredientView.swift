//
//  Ingredient.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct IngredientView: View {
    
    let ingredients: String
    
    var body: some View {
        Text(ingredients)
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
        Spacer()
    }
}

#Preview {
    IngredientView(ingredients: "水、砂糖、レモン果汁")
}
