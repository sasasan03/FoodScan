//
//  SearchResultView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI
import Charts

struct SearchResultView: View {
    
    let details = ["添加物", "成分分析", "材料"]
    
    var body: some View {
        ScrollView {
            GroupBox {
                HStack {
                    Image("coke")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .padding()
                    VStack(alignment: .leading, spacing: 15) {
                        Text("商品名：コーラ")
                        Text("ブランド：コカ・コーラ")
                        Text("カロリー：0kacl")
                        Text("販売国：台湾")
                    }
                }
            }
            NutrientChart()
            ForEach(details, id: \.self) { detail in
                NavigationLink {
                    SearchResultDetailView()
                        .navigationTitle(detail)
                } label: {
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
                }
                .padding(.horizontal, 15)
            }
            Spacer()
        }
        .padding()
    }

}

//TODO: サンプルのため後ほど削除
struct ValuePerCategory {
    var category: String
    var value: Double
}

//TODO: 
struct NutrientChart: View {
    
    let nutrients: [ValuePerCategory] = [
        .init(category: "たんぱく質 (g)", value: 5.5),
        .init(category: "脂質 (g)", value: 8.2),
        .init(category: "飽和脂肪酸 (g)", value: 2.4),
        .init(category: "炭水化物 (g)", value: 25.7),
        .init(category: "糖質 (g)", value: 21.3),
        .init(category: "食物繊維 (g)", value: 4.4),
        .init(category: "食塩相当量 (g)", value: 0.7)
    ]
    
    var body: some View {
        Chart(nutrients, id: \.category) { nutrient in
            BarMark(
                x: .value("Value", nutrient.value),
                y: .value("Category", nutrient.category)
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    SearchResultView()
}
