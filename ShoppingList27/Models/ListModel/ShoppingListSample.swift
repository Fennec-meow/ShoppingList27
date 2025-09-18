//
//  ShoppingListSample.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 18/09/2025.
//

struct ShoppingListSample {
    // Оставляю nonisolated для моковых данных чтобы не тянуть @MainActor
    nonisolated(unsafe) static var contents: [ShoppingList] = [
        ShoppingList(
            title: "Новый год",
            circleColor: .addBlue,
            circleIcon: "calendar",
            currentCount: 10,
            totalCount: 20
        ),
        ShoppingList(
            title: "Кошке",
            circleColor: .addGreen,
            circleIcon: "paw",
            currentCount: 1,
            totalCount: 4
        ),
        ShoppingList(
            title: "Вечеринка малого",
            circleColor: .addYellow,
            circleIcon: "gameController",
            currentCount: 9,
            totalCount: 20
        )
    ]
}
