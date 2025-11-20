//
//  SelectSearchTypeView .swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/10.
//

import SwiftUI

struct SelectSearchTypeView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 40) {
                Button {
                    router.push(.textSearch)
                } label: {
                    Text("文字で検索")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 44)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
                Button {
                    router.push(.barcodeSearch)
                } label: {
                    Text("バーコードで検索")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 44)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                destination.makeView()
            }
        }
    }
}

#Preview {
    let router = Router()
    SelectSearchTypeView()
        .environmentObject(router)
}
