//
//  ListsMainViewModel.swift
//  ShoppingList27
//
//  Created by Vladimir on 11.09.2025.
//

import SwiftUI

final class ListsMainViewModel: ObservableObject {
    
    // MARK: - Internal Properties
    
    @Published private(set) var lists: [ShoppingList] = ShoppingListSample.contents
    
    var shouldDisplayPlaceholder: Bool {
        lists.isEmpty
    }
    
    // MARK: - Internal Methods
    
    func insert(list: ShoppingList) {
        lists.append(list)
    }
    
}
