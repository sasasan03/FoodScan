//
//  Router.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import Foundation
import SwiftUI

enum Destination: Hashable {
    case selectSearchType
    case textSearch
    case barcodeSearch
    case searchResult
    case searchResultDetail
    
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
        case .searchResultDetail:
            SearchResultDetailView(items: nil, title: "添加物")
        }
    }
}

@MainActor
@Observable
final class Router {
    var path: [Destination] = []
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
}
