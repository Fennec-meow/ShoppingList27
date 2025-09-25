//
//  EmptyProductListView.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/16/25.
//

import SwiftUI

// MARK: - EmptyProductListView

struct EmptyProductListView: View {
    
    var body: some View {
        VStack(spacing: 28) {
            productImage
            VStack(spacing: 4) {
                title
                subtitle
            }
        }
    }
}

// MARK: - Subviews

private extension EmptyProductListView {
    
    var productImage: some View {
        Image(.addProduct)
            .resizable()
            .scaledToFit()
    }
    
    var title: some View {
        Text("Давайте спланируем покупки!")
            .font(Font.Title3.medium)
            .foregroundStyle(.grey80)
    }
    
    var subtitle: some View {
        Text("Начните добавлять товары")
            .font(Font.Body.regular)
            .foregroundStyle(.grey80)
    }
}
