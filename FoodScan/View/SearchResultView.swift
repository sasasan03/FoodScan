//
//  SearchResultView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI
import Charts

struct SearchResultView: View {
    
    @EnvironmentObject var router: Router
    let details = ["添加物", "成分分析", "材料"]
    let selectedProduct: OpenFoodFactsProduct
    
    var body: some View {
        ScrollView {
            GroupBox {
                HStack {
                    if let strURL = selectedProduct.imageUrl {
                        AsyncImage(url: URL(string: strURL)!) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .padding()
                        } placeholder: {
                            ProgressView()
                                .scaledToFit()
                                .frame(width: 100, height: 150)
                                .padding()
                        }
                    } else {
                        Image(systemName:"photo.badge.exclamationmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .padding()
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("商品名：\(selectedProduct.productName ?? "xxx")")
                        Text("ブランド：\(selectedProduct.brands ?? "xxx")")
                        Text("カロリー：\(String(describing: selectedProduct.nutriments?.energyKcal100g))kacl")
                        Text("販売国：\(selectedProduct.countries ?? "xxx")")
                    }
                }
            }
            NutrientChart(nutrients: selectedProduct.nutriments)
            ForEach(details, id: \.self) { detail in
                VStack {
                    HStack {
                        Text(detail)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 12)
                    Divider()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if detail == "添加物" {
                        router.push(.additives)
                    } else if detail == "成分分析" {
                        router.push(.componentAnalysis)
                    } else if detail == "材料" {
                        router.push(.ingredient)
                    }
                }
                .padding(.horizontal, 15)
            }
            Spacer()
        }
        .padding()
    }
    
}

struct NutrientChart: View {
    
    struct NutrientValue {
        var category: String
        var value: Double
    }
    
    let nutrients: Nutriments?
    
    var nutrientValues: [NutrientValue] {
        guard let nutrients = nutrients else { return [] }
        return [
            .init(category: "たんぱく質 (g)", value: nutrients.proteins100g ?? 0),
            .init(category: "脂質 (g)", value: nutrients.fat100g ?? 0),
            .init(category: "飽和脂肪酸 (g)", value: nutrients.saturatedFat100g ?? 0),
            .init(category: "炭水化物 (g)", value: nutrients.carbohydrates100g ?? 0),
            .init(category: "糖質 (g)", value: nutrients.sugars100g ?? 0),
            .init(category: "食物繊維 (g)", value: nutrients.fiber100g ?? 0),
            .init(category: "食塩相当量 (g)", value: nutrients.salt100g ?? 0)
        ]
    }
    
    var body: some View {
        Group{
            if nutrients != nil {
                Chart(nutrientValues, id: \.category) { nutrient in
                    BarMark(
                        x: .value("Value", nutrient.value),
                        y: .value("Category", nutrient.category)
                    )
                }
            } else {
                Text("表示する栄養素のデータがありません。")
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    let router = Router()
    let food = OpenFoodFactsProduct(
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
    SearchResultView(selectedProduct: food)
        .environmentObject(router)
}
