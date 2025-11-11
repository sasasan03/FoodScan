//
//  BarcodeSearchView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct BarcodeSearchView: View {
    var body: some View {
        NavigationLink("カメラでの検索結果を表示") {
            SearchResultView()
        }
    }
}

#Preview {
    BarcodeSearchView()
}
