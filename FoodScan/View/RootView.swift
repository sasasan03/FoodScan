//
//  RootView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            SelectSearchTypeView()
                .opacity(showSplash ? 0 : 1)
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
            }
        }
        .task {
            guard showSplash else { return }
            try? await Task.sleep(for: .seconds(2))
            await MainActor.run {
                withAnimation(.easeInOut) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    RootView()
}
