//
//  CheckboxStyle.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

struct CheckboxStyle: ButtonStyle {
    let isChecked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .foregroundColor(isChecked ? .uniTurquoise : .gray)
            .font(.system(size: 24))
            .background(
                Image(systemName: "square.fill")
                    .foregroundColor(.white)
                    .opacity(isChecked ? 1 : 0)
                    .font(.system(size: 24))
            )
    }
}
