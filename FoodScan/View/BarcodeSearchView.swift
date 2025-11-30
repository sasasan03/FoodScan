//
//  BarcodeSearchView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct BarcodeSearchView: View {
    
    @EnvironmentObject private var router: Router
    private let sampleFood = OpenFoodFactsProduct(
        productName: "ポテトチップス",
        brands: "Calbee",
        countries: "日本",
        imageUrl: "https://example.com/chips.jpg",
        additivesTags: ["en:e621"],
        nutriments: Nutriments(
            energyKcal100g: 550,
            proteins100g: 6.3,
            fat100g: 35.0,
            saturatedFat100g: 3.5,
            carbohydrates100g: 50.0,
            sugars100g: 2.1,
            fiber100g: 3.0,
            salt100g: 1.2
        ),
        ingredientsText: "水", ingredientsAnalysisTags: ["サンプル"]
    )
    
    var body: some View {
        Button {
            router.push(.searchResult(sampleFood))
        } label: {
            Text("バーコード検索")
        }
    }
}

#Preview {
    BarcodeSearchView()
}
