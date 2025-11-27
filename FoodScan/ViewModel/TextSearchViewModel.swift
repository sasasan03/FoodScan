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
    @Published var errorMessage: String?
    
    func searchFood(_ name: String) {
        Task {
            do {
                let result = try await client.searchFood(itemName: name)
                result
                    .receive(on: DispatchQueue.main) 
                    .sink(receiveCompletion: { completed in
                    switch completed {
                    case .finished:
                        print("completed finished")
                    case .failure(let failure):
                        self.errorMessage = self.message(from: failure)
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
        return "\(error)"
    }
}
