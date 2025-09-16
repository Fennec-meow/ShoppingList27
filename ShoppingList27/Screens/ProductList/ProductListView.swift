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
    
    private let backButtonTitleFont: Font = Font.Headline.medium
    
    var body: some View {
        mainView
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    optionsButton
                }
            }
            .navigationBarBackButtonHidden()
    }
    
    private var mainView: some View {
        ZStack(alignment: .bottom) {
            Color.backgroundScreen
                .ignoresSafeArea()
                productListTable
                    .disabled(products.isEmpty)
                    .opacity(products.isEmpty ? 0 : 1)
                VStack {
                    EmptyProductListView()
                        .padding(.top, 40)
                        .padding(.horizontal)
                    Spacer()
                }
                .opacity(products.isEmpty ? 1 : 0)
            
            BaseButton(title: "Добавить товар") {
                addProductButtonWasTapped()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .searchable(text: $searchedProductName, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            UISearchBar.appearance().tintColor = .uniTurquoise
        }
    }
    
    private var productListTable: some View {
        List {
            let id = products.first?.id
            ForEach(products, id: \.id) { product in
                ProductCellView(product: product)
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(.strokePanel)
                    .listRowSeparator(id == product.id ? .hidden : .visible, edges: .top)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        return -20
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        createDeleteProductButton(product: product)
                        createEditProductButton(product: product)
                    }
            }
            Spacer(minLength: 100)
                .safeAreaPadding(.bottom)
                .listRowBackground(Color.clear)
                .listRowSeparatorTint(.clear)
        }
        .listStyle(.plain)
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
    
    private var optionsButton: some View {
        Button {
            optionsButtonWasTapped()
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .tint(.grey80)
    }
    
    private func createDeleteProductButton(product: Product) -> some View {
        Button {
            deleteProductButtonWasPressed(product: product)
        }
        label: {
            Image(systemName: "trash")
                .environment(\.symbolVariants, .none)
        }
        .tint(.uniRed)
    }
    
    private func createEditProductButton(product: Product) -> some View {
        Button {
            editProductButtonWasPressed(product: product)
        }
        label: {
            Image(systemName: "square.and.pencil")
        }
        .tint(.uniGrey)
    }
    
    private func addProductButtonWasTapped() {
        print("Tapped add product button")
    }
    
    private func optionsButtonWasTapped() {
        print("Tapped options button")
    }
    
    private func deleteProductButtonWasPressed(product: Product) {
        print("Selected to delete product: \(product.name)")
    }
    
    private func editProductButtonWasPressed(product: Product) {
        print("Selected to edit product: \(product.name)")
    }
}

#Preview {
    @Previewable @State var isProductListPresented: Bool = true
    @Previewable @State var products: [Product] = [Product.mock1,
                                                   Product.mock2,
                                                   Product.mock3]
//    @Previewable @State var products: [Product] = []
    
    NavigationStack {
        VStack(spacing: 80) {
            Text("Main Screen")
            BaseButton(title: "Show Product List") {
                isProductListPresented = true
            }
        }
        .padding()
            .navigationDestination(isPresented: $isProductListPresented) {
                ProductListView(listName: "Новый год", products: products)
            }
    }
}
