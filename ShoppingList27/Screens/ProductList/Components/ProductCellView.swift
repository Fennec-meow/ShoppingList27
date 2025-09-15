//
//  ProductCellView.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

struct ProductCellView: View {
    private let product: ProductCellModel
    
    init(product: ProductCellModel) {
        self.product = product
    }
    
    var body: some View {
        HStack {
            Button("", action: { product.toggleChecked()})
                .buttonStyle(.checkbox(isChecked: product.isChecked))
            
            Group {
                Text(product.product.name)
                
                Spacer()
                Text("\(product.product.count) \(product.product.unitMeasure.shortName)")
            }
            .foregroundColor(product.isChecked ? .hint : .grey80)
        }
    }
}

#Preview {
    let productCellPreview = VStack(alignment: .leading, spacing: 20) {
        ProductCellView(product: ProductCellModel(model: .mock1))
            .padding(.horizontal, 28)
        Divider()
        ProductCellView(product: ProductCellModel(model: .mock2))
            .padding(.horizontal, 28)
        Divider()
        ProductCellView(product: ProductCellModel(model: .mock3))
            .padding(.horizontal, 28)
    }
    .frame(maxHeight: .infinity)
    .background(Color.backgroundScreen)
    
    productCellPreview
        .colorScheme(.light)
    
    productCellPreview
        .colorScheme(.dark)
}
