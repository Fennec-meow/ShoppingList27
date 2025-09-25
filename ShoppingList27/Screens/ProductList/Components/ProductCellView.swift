//
//  ProductCellView.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

// MARK: - ProductCellView

struct ProductCellView: View {
    var product: Product
    var action: ((Product) -> Void)?
    
    var body: some View {
        HStack {
            Button("", action: { guard let action else { return }
                action(product)
            })
            .buttonStyle(.checkbox(isChecked: product.isBought))
            
            Group {
                Text(product.name)
                    .font(Font.Body.regular)
                Spacer()
                Text("\(product.count) \(product.unitMeasure.shortName)")
                    .font(Font.Body.regular)
            }
            .foregroundColor(product.isBought ? .greyList : .grey80)
        }
    }
}

// MARK: - Preview

#Preview {
    ProductCellView(product: ProductSample.contents[0])
        .frame(maxHeight: .infinity)
        .background(Color.backgroundScreen)
}
