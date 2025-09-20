//
//  ProductListView.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/12/25.
//

import SwiftUI

struct ProductListView: View {
    
    @State var viewModel: ProductListViewModelProtocol
    
    @Environment(\.dismiss) private var dismiss
    @Environment(NavigationRoute.self) private var router
    
    private let backButtonTitleFont: Font = Font.Headline.medium
    
    init(listName: String, viewModel: ProductListViewModelProtocol? = nil) {
        self.viewModel = viewModel ?? ProductListViewModel(listName: listName)
    }
    
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
            ZStack {
                productListTable
                    .disabled(viewModel.products.isEmpty)
                    .opacity(viewModel.products.isEmpty ? 0 : 1)
                
                VStack {
                    EmptyProductListView()
                        .padding(.top, 40)
                        .padding(.horizontal)
                    Spacer()
                }
                .opacity(viewModel.products.isEmpty ? 1 : 0)
            }
            .safeAreaInset(edge: .bottom, spacing: 60) {
                BaseButton(title: "Добавить товар") {
                    addProductButtonWasTapped()
                    router.handleNavigateTo(.createProduct)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .searchable(text: $viewModel.searchedProductName, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            UISearchBar.appearance().tintColor = .uniTurquoise
        }
    }
    
    private var productListTable: some View {
        List {
            let id = viewModel.products.first?.id
            ForEach(viewModel.products, id: \.id) { product in
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
        }
        .listStyle(.plain)
    }
    
    private var backButtonTitle: some View {
        Text(viewModel.listName)
            .font(backButtonTitleFont)
    }
    
    private var backButton: some View {
        Button {
            router.handleGoBack()
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
        viewModel.deleteProduct(product)
    }
    
    private func editProductButtonWasPressed(product: Product) {
        viewModel.editProduct(product)
    }
}

#Preview {
    @Previewable @State var isProductListPresented: Bool = true
    
    let products: [Product] = [Product.mock1,
                               Product.mock2,
                               Product.mock3]
    
//    let products: [Product] = []
    
    let viewModel = ProductListViewModelMock(listName: "Новый год", products: products)
    let router = NavigationRoute()
    
    NavigationStack {
        VStack(spacing: 80) {
            Text("Main Screen")
            BaseButton(title: "Show Product List") {
                isProductListPresented = true
            }
        }
        .padding()
            .navigationDestination(isPresented: $isProductListPresented) {
                ProductListView(listName: "Новый год", viewModel: viewModel)
                    .environment(router)
            }
    }
    .environment(router)
}
