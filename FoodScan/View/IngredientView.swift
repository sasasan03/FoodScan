//
//  Ingredient.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct IngredientView: View {
    
    let ingredients = ["水","砂糖","レモン果汁"]
    
    var body: some View {
        ForEach(ingredients, id: \.self) { ingredient in
            VStack(alignment: .leading) {
                Text(ingredient)
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
    IngredientView()
}
