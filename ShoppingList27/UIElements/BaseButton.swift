//
//  baseButton.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/3/25.
//

import SwiftUI

struct BaseButton: View {
    var isActive: Bool = true
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.Headline.medium)
                .foregroundStyle(isActive ? Color.white : Color.hint)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(isActive ? Color.uniTurquoise : Color.button)
                .clipShape(RoundedRectangle(cornerRadius: 100))
        }
        .contentShape(RoundedRectangle(cornerRadius: 100))
        .disabled(!isActive)
    }
}

#Preview {
    let title = "Test"
    let action = { print("I was tapped!") }
    
    VStack {
        BaseButton(
            title: title,
            action: action
        )
        BaseButton(
            isActive: false,
            title: title,
            action: action
        )
    }
    .padding(.horizontal, 16)
}
