//
//  OpenFoodFactsAPI.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/09.
//

import Foundation

enum OpenFoodFactsAPIError: Error {
    case invalidURL
    case networkError
    case invalidResponse(statusCode: Int)
    case decodingError(Error)
}
