//
//  OpenFoodFactsAPI.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/09.
//

import Foundation
import Combine

class OpenFoodFactsApiClient {
    private let sesion = URLSession.shared

    func searchFood(itemName: String) async throws -> AnyPublisher<[OpenFoodFactsProduct], Error> {
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
                    "ingredients_text",
                    "additives_tags",
                    "nutriments",
                    "ingredients_analysis_tags"
                ].joined(separator: ",")
            ),
            URLQueryItem(name: "page_size", value: "10")
        ]
        
        guard let componentsURL = components.url else { throw OpenFoodFactsAPIError.invalidURL }
        
        var request = URLRequest(url: componentsURL)
        request.httpMethod = "GET"
        request.setValue("FoodScan - iOS - 1.0", forHTTPHeaderField: "User-Agent")
        
        return sesion.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
                }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.products }
            .eraseToAnyPublisher()
    }
}
