//
//  EmptyProductListView.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/16/25.
//

import SwiftUI

struct EmptyProductListView: View {
    
    private var titleFont: Font {
        Font.Title3.medium
    }
    
    private var subtitleFont: Font {
        Font.Body.regular
    }
    
    var body: some View {
        VStack(spacing: 28) {
            productImage
            VStack(spacing: 4) {
                title
                subtitle
            }
        }
    }
    
    private var productImage: some View {
        Image(.addProduct)
            .resizable()
            .scaledToFit()
    }
    
    private var title: some View {
        Text("Давайте спланируем покупки!")
            .font(titleFont)
    }
    
    private var subtitle: some View {
        Text("Начните добавлять товары")
            .font(subtitleFont)
    }
}
