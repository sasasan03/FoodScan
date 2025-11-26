//
//  Entity.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/08.
//

import Foundation

struct SearchResponse: Decodable {
    let products: [OpenFoodFactsProduct]
}

//🟡・・・食品カードで使用
//🟣・・・棒グラフで使用
//⚪️・・・リストで使用
struct OpenFoodFactsProduct: Decodable, Hashable {
    let productName: String? //🟡商品名(１)
    let brands: String? //🟡ブランド（２）
    let countries: String? //🟡販売国(４)
    let imageUrl: String?
    let additivesTags: [String]? //⚪️含まれる添加物を全て取得
    let nutriments: Nutriments?
    let ingredientsText: String? //⚪️原材料名
    let ingredientsAnalysisTags: [String]? //⚪️成分分析
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brands
        case countries
        case imageUrl = "image_front_url"
        case additivesTags = "additives_tags"
        case nutriments
        case ingredientsText = "ingredients_text"
        case ingredientsAnalysisTags = "ingredients_analysis_tags"
    }
}

struct Nutriments: Decodable, Hashable {
    let energyKcal100g: Double? //🟡カロリー（３）
    let proteins100g: Double? //🟣タンパク質
    let fat100g: Double?//🟣脂質
    let saturatedFat100g: Double?//🟣飽和脂肪酸
    let carbohydrates100g: Double?//🟣炭水化物
    let sugars100g: Double?//🟣糖質
    let fiber100g: Double?//🟣食物繊維
    let salt100g: Double?//🟣塩
    
    enum CodingKeys: String, CodingKey {
        case energyKcal100g = "energy-kcal_100g"
        case proteins100g = "proteins_100g"
        case fat100g = "fat_100g"
        case saturatedFat100g = "saturated-fat_100g"
        case carbohydrates100g = "carbohydrates_100g"
        case sugars100g = "sugars_100g"
        case fiber100g = "fiber_100g"
        case salt100g = "salt_100g"
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        func flex(_ k: CodingKeys) -> Double? {
            (try? c.decode(FlexibleDouble.self, forKey: k))?.value
        }
        energyKcal100g = flex(.energyKcal100g)
        proteins100g = flex(.proteins100g)
        fat100g = flex(.fat100g)
        saturatedFat100g = flex(.saturatedFat100g)
        carbohydrates100g = flex(.carbohydrates100g)
        sugars100g = flex(.sugars100g)
        fiber100g = flex(.fiber100g)
        salt100g = flex(.salt100g)
    }
    
    //TODO: ダミー用のinitで使用。不要になった場合に削除
    init(
        energyKcal100g: Double? = nil,
        proteins100g: Double? = nil,
        fat100g: Double? = nil,
        saturatedFat100g: Double? = nil,
        carbohydrates100g: Double? = nil,
        sugars100g: Double? = nil,
        fiber100g: Double? = nil,
        salt100g: Double? = nil
    ) {
        self.energyKcal100g = energyKcal100g
        self.proteins100g = proteins100g
        self.fat100g = fat100g
        self.saturatedFat100g = saturatedFat100g
        self.carbohydrates100g = carbohydrates100g
        self.sugars100g = sugars100g
        self.fiber100g = fiber100g
        self.salt100g = salt100g
    }
}

/// キーに対して返ってくる値の型が違っているため、対応が必要
/// （例）プロテインがAではInt型、BではString型
struct FlexibleDouble: Decodable {
    let value: Double?
    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if let d = try? c.decode(Double.self) {
            value = d
        } else if let s = try? c.decode(String.self) {
            value = Double(s.replacingOccurrences(of: ",", with: "."))
        } else {
            value = nil
        }
    }
}


//TODO: ダミー用のデータ。後に削除
struct DummyData {
    let sampleProducts: [OpenFoodFactsProduct] = [
        OpenFoodFactsProduct(
            productName: "チョコレートケーキ",
            brands: "Lotte",
            countries: "日本",
            imageUrl: "https://example.com/cake.jpg",
            additivesTags: ["en:e322", "en:e500"],
            nutriments: Nutriments(
                energyKcal100g: 420,
                proteins100g: 5.2,
                fat100g: 22.5,
                saturatedFat100g: 12.3,
                carbohydrates100g: 48.7,
                sugars100g: 35.0,
                fiber100g: 2.1,
                salt100g: 0.3
            ),
            ingredientsText: "水", ingredientsAnalysisTags: ["サンプル"]
        ),
        OpenFoodFactsProduct(
            productName: "バニラアイスクリーム",
            brands: "Haagen-Dazs",
            countries: "日本,アメリカ",
            imageUrl: "https://example.com/icecream.jpg",
            additivesTags: ["en:e412", "en:e410"],
            nutriments: Nutriments(
                energyKcal100g: 270,
                proteins100g: 3.8,
                fat100g: 17.0,
                saturatedFat100g: 10.2,
                carbohydrates100g: 25.0,
                sugars100g: 22.5,
                fiber100g: 0.0,
                salt100g: 0.12
            ),
            ingredientsText: "水", ingredientsAnalysisTags: ["サンプル"]
        ),
        OpenFoodFactsProduct(
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
        ),
        OpenFoodFactsProduct(
            productName: "ミネラルウォーター",
            brands: "Evian",
            countries: "フランス,日本",
            imageUrl: "https://example.com/water.jpg",
            additivesTags: [],
            nutriments: Nutriments(
                energyKcal100g: 0,
                proteins100g: 0,
                fat100g: 0,
                saturatedFat100g: 0,
                carbohydrates100g: 0,
                sugars100g: 0,
                fiber100g: 0,
                salt100g: 0.01
            ),
            ingredientsText: "水", ingredientsAnalysisTags: ["サンプル"]
        ),
        OpenFoodFactsProduct(
            productName: "クロワッサン",
            brands: "Paul",
            countries: "フランス,日本",
            imageUrl: "https://example.com/croissant.jpg",
            additivesTags: ["en:e322", "en:e471"],
            nutriments: Nutriments(
                energyKcal100g: 406,
                proteins100g: 8.0,
                fat100g: 21.0,
                saturatedFat100g: 12.0,
                carbohydrates100g: 45.0,
                sugars100g: 9.0,
                fiber100g: 2.5,
                salt100g: 0.8
            ),
            ingredientsText: "水", ingredientsAnalysisTags: ["サンプル"]
        )
    ]
}
