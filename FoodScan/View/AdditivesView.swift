//
//  AdditivesView.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/20.
//

import SwiftUI

struct AdditivesView: View {
    
    let additives: [String]
    
    var body: some View {
        if !additives.isEmpty {
            ForEach(additives, id: \.self) { additive in
                let convertJP = AdditiveTranslator.convertToJP(additive)
                VStack(alignment: .leading) {
                    Text(convertJP)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 3)
        } else {
            Text("添加物の情報がありません")
        }
        Spacer()
    }
}

#Preview {
    AdditivesView(additives: ["プレーンキャラメル","スクラロース","アセスルファムK"])
}
