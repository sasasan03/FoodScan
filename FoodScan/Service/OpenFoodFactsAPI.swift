//
//  OpenFoodFactsAPI.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/09.
//

import Foundation

struct OpenFoodFactsApiClient {
    func searchFood(itemName: String) async throws -> [OpenFoodFactsProduct] {
        //TODO: ステージング環境(net)で行っているため本番環境(org)に切り替える必要あり
        guard var components = URLComponents(string: "https://world.openfoodfacts.net/api/v2/search") else { throw OpenFoodFactsAPIError.invalidURL }
        components.queryItems = [
            URLQueryItem(name: "categories_tags_ja", value: itemName),
            URLQueryItem(
                name: "fields",
                value: [
                    "product_name",
                    "brands",
                    "countries",
                    "image_front_url",
                    "additives_n",
                    "additives_tags",
                    "nutriments"
                ].joined(separator: ",")
            ),
            URLQueryItem(name: "page_size", value: "10")
        ]
        
        guard let componentsURL = components.url else { throw OpenFoodFactsAPIError.invalidURL }
        
        var request = URLRequest(url: componentsURL)
        request.httpMethod = "GET"
        request.setValue("FoodScan - iOS - 1.0", forHTTPHeaderField: "User-Agent")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenFoodFactsAPIError.networkError
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw OpenFoodFactsAPIError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(SearchResponse.self, from: data)
        return result.products
    }
}
