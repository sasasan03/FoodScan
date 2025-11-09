//
//  SplashScreenView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        Image("splashImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200,height: 200)
    }
}

#Preview {
    SplashScreenView()
}
