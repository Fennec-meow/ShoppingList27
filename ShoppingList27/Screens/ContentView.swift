//
//  ContentView.swift
//  ShoppingList27
//
//  Created by Nikita Tsomuk on 01.09.2025.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    var body: some View {
      
        HStack {
            Image("snowflake")
                .renderingMode(.template)
                .foregroundColor(.addGreen)
            Text("Hello, Factory!")
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    Color.blue
         .ignoresSafeArea()
         .overlay(
    ContentView()
    )
}
