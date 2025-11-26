//
//  BarcodeSearchView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct BarcodeSearchView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button {
            router.push(.searchResult)
        } label: {
            Text("バーコード検索")
        }
    }
}

#Preview {
    BarcodeSearchView()
}
