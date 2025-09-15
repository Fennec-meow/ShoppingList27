//
//  ProductCellView.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

struct ProductCellView: View {
    var product: Product
    
    var body: some View {
        HStack {
            Button("", action: { product.toggleBought() })
                .buttonStyle(.checkbox(isChecked: product.isBought))
            
            Group {
                Text(product.name)
                Spacer()
                Text("\(product.count) \(product.unitMeasure.shortName)")
            }
            .foregroundColor(product.isBought ? .greyList : .grey80)
        }
    }
}

#Preview {
    let productCellPreview = VStack(alignment: .leading, spacing: 20) {
        ProductCellView(product: .mock1)
            .padding(.horizontal, 28)
        Divider()
        ProductCellView(product: .mock2)
            .padding(.horizontal, 28)
        Divider()
        ProductCellView(product: .mock3)
            .padding(.horizontal, 28)
    }
    .frame(maxHeight: .infinity)
    .background(Color.backgroundScreen)
    
    productCellPreview
        .colorScheme(.light)
    
    productCellPreview
        .colorScheme(.dark)
}
