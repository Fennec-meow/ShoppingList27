//
//  ProductListViewModel.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/18/25.
//

import SwiftUI

@MainActor
@Observable final class ProductListViewModel: ProductListViewModelProtocol {
    let listName: String
    var products: [Product] = []

    var searchedProductName: String = ""
    
    init(listName: String) {
        self.listName = listName
    }
    
    func addProduct() {

    }
    
    func deleteProduct(_ product: Product) {

    }
    
    func editProduct(_ product: Product) {

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
}

@MainActor
@Observable final class ProductListViewModelMock: ProductListViewModelProtocol {
    let listName: String
    var products: [Product]

    var searchedProductName: String = ""
    
    init(listName: String, products: [Product]? = nil) {
        self.listName = listName
        self.products = products ?? []
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
}
