//
//  String-Extension.swift
//  FoodScan
//
//  Created by sako0602 on 2025/11/30.
//

import Foundation

extension String {
    
    func splitByComma() -> [String] {
        self.components(separatedBy: CharacterSet(charactersIn: "、,"))
            .map { $0.trimmingCharacters(in: .whitespaces) }
    }
    
}
