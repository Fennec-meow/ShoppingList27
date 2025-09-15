//
//  ProductListView.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/12/25.
//

import SwiftUI

struct ProductListView: View {
    let listName: String
    let products: [Product]
    
    @State private var searchedProductName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    private let backButtonTitleFont: Font = Font.system(size: 17, weight: .medium)
    
    var body: some View {
        mainView
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
            .navigationBarBackButtonHidden()
    }
    
    private var mainView: some View {
        ZStack(alignment: .bottom) {
            Color.backgroundScreen
                .ignoresSafeArea()
            BaseButton(title: "Добавить товар") {
                addProductButtonWasTapped()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .searchable(text: $searchedProductName)
        .onAppear {
            UISearchBar.appearance().tintColor = .uniTurquoise
        }
    }
    
    private var productListTable: some View {
        List(products, id: \.id) { product in
            ProductCellView(product: product)
        }
    }
    
    private var backButtonTitle: some View {
        Text(listName)
            .font(backButtonTitleFont)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "chevron.backward")
                backButtonTitle
            }
        }
        .tint(.grey80)
    }
    
    private func addProductButtonWasTapped() {
        
    }
}

#Preview {
    @Previewable @State var isProductListPresented: Bool = true
    NavigationStack {
        VStack(spacing: 80) {
            Text("Main Screen")
            BaseButton(title: "Show Product List") {
                isProductListPresented = true
            }
        }
        .padding()
            .navigationDestination(isPresented: $isProductListPresented) {
                ProductListView(listName: "Новый год", products: <#[Product]#>)
            }
    }
}
