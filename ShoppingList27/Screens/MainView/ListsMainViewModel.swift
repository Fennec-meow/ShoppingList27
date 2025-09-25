//
//  ListsMainViewModel.swift
//  ShoppingList27
//
//  Created by Vladimir on 11.09.2025.
//

import SwiftUI
import SwiftData

// MARK: - ListsMainViewModel

final class ListsMainViewModel: ObservableObject {
    
    // MARK: Internal Properties
    
    @Published private(set) var lists: [ShoppingList] = ShoppingListSample.contents
    
    var shouldDisplayPlaceholder: Bool {
        lists.isEmpty
    }
}

// MARK: - Public Methods

extension ListsMainViewModel {
    func insert(list: ShoppingList) {
        lists.append(list)
    }
    
    func editList(_ list: ShoppingList) {
        print("Selected to edit the list: \(list.title)")
    }
    
    func duplicatingList(
        _ list: ShoppingList,
        context: ModelContext
    ) -> ShoppingList {
        
        let copyCount = countExistingCopies(of: list, in: context)
        let newNumber = copyCount + 1
        
        let newList = ShoppingList(
            title: "\(list.title)(\(newNumber))",
            circleColor: list.circleColor,
            circleIcon: list.circleIcon
        )
        
        if !list.productList.isEmpty {
            for product in list.productList {
                let newProduct = Product(
                    name: product.name,
                    count: product.count,
                    unitMeasure: product.unitMeasure,
                    isBought: false,
                    list: newList
                )
                newList.productList.append(newProduct)
            }
        }
        
        context.insert(newList)
        saveContext(context)
        print("Selected to duplicate the list: \(list.title)")
        
        return newList
    }
    
    func deleteList(_ list: ShoppingList, context: ModelContext) {
        context.delete(list)
        saveContext(context)
        print("List '\(list.title)' deleted successfully")
    }
}

// MARK: - Private Methods

private extension ListsMainViewModel {
    func saveContext(_ context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    func countExistingCopies(
        of originalList: ShoppingList,
        in context: ModelContext
    ) -> Int {
        
        do {
            let allLists = try context.fetch(FetchDescriptor<ShoppingList>())
            return allLists.filter { $0.title.contains("\(originalList.title)(") }.count
        } catch {
            return 0
        }
    }
}
