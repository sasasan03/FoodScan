//
//  Router.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import Foundation
import Combine
import SwiftUI

enum Destination: Hashable {
    case selectSearchType
    case textSearch
    case barcodeSearch
    case searchResult
    case componentAnalysis
    case additives
    case ingredient
    
    @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .selectSearchType:
            SelectSearchTypeView()
        case .textSearch:
            TextSearchView()
                .navigationTitle("open Food facts")
                .toolbarTitleDisplayMode(.large)
        case .barcodeSearch:
            BarcodeSearchView()
        case .searchResult:
            SearchResultView()
        case .componentAnalysis:
            ComponentAnalysisView()
                .navigationTitle("成分分析")
        case .additives:
            AdditivesView()
                .navigationTitle("添加物")
        case .ingredient:
            IngredientView()
                .navigationTitle("材料")
        }
    }
}

@MainActor
final class Router: ObservableObject {
    @Published var path: [Destination] = []
    let route = PassthroughSubject<Destination,Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        route
            .sink { screen in
                self.path.append(screen)
            }.store(in: &cancellables)
    }
    
    func push(_ destination: Destination) {
        route.send(destination)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
}
