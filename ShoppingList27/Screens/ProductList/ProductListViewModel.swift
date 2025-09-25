//
//  ProductListViewModel.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/18/25.
//

import SwiftUI
import SwiftData

// MARK: - ProductListViewModel

@MainActor
@Observable final class ProductListViewModel: ProductListViewModelProtocol {
    
    // MARK: Private Properties
    
    private let shoppingList: ShoppingList?
    
    // MARK: Public Properties
    
    var router: NavigationRoute?
    var modelContext: ModelContext?
    
    var searchedProductName: String = ""
    
    var listName: String {
        shoppingList?.title ?? "Unknown List"
    }
    
    var products: [Product] {
        shoppingList?.productList ?? []
    }
    
    // MARK: Initializer
    
    init(shoppingList: ShoppingList? = nil) {
        self.shoppingList = shoppingList
    }
}

// MARK: - Public Methods - ProductListViewModel

extension ProductListViewModel {
    
    func setRouter(_ router: NavigationRoute?) {
        self.router = router
    }
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addProduct() {
        guard let shoppingList else { return }
        router?.showSheet(.createProduct(list: shoppingList, product: nil))
    }
    
    func deleteProduct(_ product: Product) {
        do {
            modelContext?.delete(product)
            try modelContext?.save()
        } catch {
            print("Something went wrong")
        }
    }
    
    func editProduct(_ product: Product) {
        guard let shoppingList else { return }
        router?.showSheet(.createProduct(list: shoppingList, product: product))
    }
    
    func toggleProductIsBought(_ product: Product) {
        do {
            product.isBought.toggle()
            try modelContext?.save()
        } catch {
            print("Something went wrong")
        }
    }
    
    func hideView() {
        router?.pop()
    }
}

@MainActor
protocol ProductListViewModelProtocol {
    var listName: String { get }
    var products: [Product] { get }
    var searchedProductName: String { get set }
    
    func addProduct()
    func deleteProduct(_ product: Product)
    func editProduct(_ product: Product)
    func setRouter(_ router: NavigationRoute?)
    func hideView()
    func setModelContext(_ modelContext: ModelContext)
    func toggleProductIsBought(_ product: Product)
}

@MainActor
@Observable final class ProductListViewModelMock: ProductListViewModelProtocol {
    
    // MARK: Public Properties
    
    let listName: String
    var products: [Product]
    var router: NavigationRoute?
    
    var searchedProductName: String = ""
    
    // MARK: Initializer
    
    init(
        listName: String,
        products: [Product]? = nil,
        router: NavigationRoute? = nil
    ) {
        self.listName = listName
        self.products = products ?? []
        self.router = router
    }
}

// MARK: - Public Methods - ProductListViewModelMock

extension ProductListViewModelMock {
    
    func toggleProductIsBought(_ product: Product) {
        
    }
    
    func addProduct() {
        print("Add Product button was tapped")
    }
    
    func deleteProduct(_ product: Product) {
        print("Selected to delete product: \(product.name)")
    }
    
    func editProduct(_ product: Product) {
        print("Selected to edit product: \(product.name)")
    }
    
    func setRouter(_ router: NavigationRoute?) {
        
    }
    
    func setModelContext(_ modelContext: ModelContext) {
        
    }
    
    func hideView() {
        
    }
}
