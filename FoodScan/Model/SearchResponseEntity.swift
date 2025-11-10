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
struct OpenFoodFactsProduct: Decodable {
    let productName: String? //🟡商品名(１)
    let brands: String? //🟡ブランド（２）
    let countries: String? //🟡販売国(４)
    let imageUrl: String?
    let additivesTags: [String]? //⚪️含まれる添加物を全て取得
    let nutriments: Nutriments?
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brands
        case countries
        case imageUrl = "image_front_url"
        case additivesTags = "additives_tags"
        case nutriments
    }
}

struct Nutriments: Decodable {
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
