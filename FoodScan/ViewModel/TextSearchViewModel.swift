//
//  TextSearchViewModel.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/27.
//

import Foundation
import Combine

@MainActor
final class TextSearchViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private let client = OpenFoodFactsApiClient()
    @Published var foods: [OpenFoodFactsProduct]?
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func searchFood() {
        isLoading = true
        Task {
            do {
                let result = try await client.searchFood(itemName: searchText)
                result
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completed in
                    switch completed {
                    case .finished:
                        self.isLoading = false
                    case .failure(let failure):
                        self.errorMessage = self.message(from: failure)
                        self.isLoading = false
                    }
                }, receiveValue: { value in
                    self.foods = value
                }).store(in: &cancellable)
            } catch {
                errorMessage = message(from: error)
            }
        }
    }
    
    private func message(from error: Error) -> String {
        return "エラー：\n\(error)"
    }
}
