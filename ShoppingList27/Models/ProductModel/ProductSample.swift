//
//  ProductSample.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 19/09/2025.
//

struct ProductSample {
    nonisolated(unsafe) static var contents: [Product] = [
        Product(
            name: "Чайник",
            count: 12,
            unitMeasure: .piece,
            isBought: true,
            list: ShoppingListSample.contents[0]
        ),
        Product(
            name: "Вода",
            count: 4,
            unitMeasure: .liter,
            isBought: false,
            list: ShoppingListSample.contents[1]
        ),
        Product(
            name: "Макароны",
            count: 2,
            unitMeasure: .kilogram,
            isBought: true,
            list: ShoppingListSample.contents[2]
        )
    ]
}
