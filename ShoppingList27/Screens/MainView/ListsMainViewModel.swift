//
//  ListsMainViewModel.swift
//  ShoppingList27
//
//  Created by Vladimir on 11.09.2025.
//

import SwiftUI

final class ListsMainViewModel: ObservableObject {
    
    // MARK: - Internal Properties
    
    @Published private(set) var lists: [ListItem] = []
    
    var shouldDisplayPlaceholder: Bool {
        lists.isEmpty
    }
    
    // MARK: - Internal Methods
    
    func insert(list: ListItem) {
        lists.append(list)
    }
    
}
