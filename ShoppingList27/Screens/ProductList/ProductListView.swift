//
//  ProductListView.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/12/25.
//

import SwiftUI
import SwiftData

// MARK: - ProductListView

struct ProductListView: View {
    
    @Environment(NavigationRoute.self) private var router
    @Environment(\.modelContext) private var modelContext
    
    @State var viewModel: ProductListViewModelProtocol
    
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
            .onAppear {
                self.viewModel.setRouter(router)
                self.viewModel.setModelContext(modelContext)
            }
    }
    
    // MARK: Initializer
    
    init(
        selectedShoppingList: ShoppingList,
        viewModel: ProductListViewModelProtocol? = nil
    ) {
        self.viewModel = viewModel ?? ProductListViewModel(shoppingList: selectedShoppingList)
    }
}

// MARK: - Subviews

private extension ProductListView {
    
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
    
    var productListTable: some View {
        List {
            let id = viewModel.products.first?.id
            ForEach(viewModel.products, id: \.id) { product in
                ProductCellView(product: product, action: productCellCheckBoxWasPressed)
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
    
    var backButtonTitle: some View {
        Text(viewModel.listName)
            .font(Font.Headline.medium)
    }
    
    var backButton: some View {
        Button {
            viewModel.hideView()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "chevron.backward")
                backButtonTitle
            }
        }
        .tint(.grey80)
    }
    
    var optionsButton: some View {
        Button {
            optionsButtonWasTapped()
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .tint(.grey80)
    }
}

// MARK: - Private Methods

private extension ProductListView {
    
    func createDeleteProductButton(product: Product) -> some View {
        Button {
            deleteProductButtonWasPressed(product: product)
        }
        label: {
            Image(systemName: "trash")
                .environment(\.symbolVariants, .none)
        }
        .tint(.uniRed)
    }
    
    func createEditProductButton(product: Product) -> some View {
        Button {
            editProductButtonWasPressed(product: product)
        }
        label: {
            Image(systemName: "square.and.pencil")
        }
        .tint(.uniGrey)
    }
    
    func addProductButtonWasTapped() {
        viewModel.addProduct()
    }
    
    func optionsButtonWasTapped() {
        print("Tapped options button")
    }
    
    func deleteProductButtonWasPressed(product: Product) {
        viewModel.deleteProduct(product)
    }
    
    func editProductButtonWasPressed(product: Product) {
        viewModel.editProduct(product)
    }
    
    func productCellCheckBoxWasPressed(_ product: Product) {
        viewModel.toggleProductIsBought(product)
    }
}
// MARK: - Preview

#Preview {
    //    @Previewable @State var hasCompletedOnboarding: Bool = true
    //
    //    let products: [Product] = ProductSample.contents
    
    //    let list: ShoppingList = ShoppingList(title: "Новый год", circleColor: .blue, circleIcon: Image(systemName: "plus))")
    //
    //    let viewModel = ProductListViewModelMock(listName: "Новый год", products: products)
    //    let router = NavigationRoute()
    //
    //    VStack {
    //        ProductListView(viewModel: viewModel)
    //    }
}
