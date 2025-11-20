//
//  AdditivesView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct AdditivesView: View {
    
    let additives = ["プレーンキャラメル","スクラロース","アセスルファムK"]
    
    var body: some View {
        ForEach(additives, id: \.self) { additive in
            VStack(alignment: .leading) {
                Text(additive)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
        Spacer()
    }
}

#Preview {
    AdditivesView()
}
