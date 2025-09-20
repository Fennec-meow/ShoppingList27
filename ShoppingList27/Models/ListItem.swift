//
//  ListItem.swift
//  ShoppingList27
//
//  Created by Hajime4life on 07.09.2025.
//

import SwiftUI

struct ListItem: Identifiable, Equatable, Hashable {
    let id: UUID
    var title: String
    var circleColor: Color
    var circleIcon: String
    var currentCount: Int
    var totalCount: Int
    
    init(
        title: String,
        circleColor: Color,
        circleIcon: String,
        currentCount: Int,
        totalCount: Int
    ) {
        self.id = UUID()
        self.title = title
        self.circleColor = circleColor
        self.circleIcon = circleIcon
        self.currentCount = currentCount
        self.totalCount = totalCount
    }
    
    // Моковый элемент для превью
    static var mock: ListItem {
        ListItem(
            title: "Новый год",
            circleColor: .addBlue,
            circleIcon: "calendar",
            currentCount: 10,
            totalCount: 20
        )
    }
    static var mock2: ListItem {
        ListItem(
            title: "Кошке",
            circleColor: .addGreen,
            circleIcon: "paw",
            currentCount: 1,
            totalCount: 4
        )
    }
    static var mock3: ListItem {
        ListItem(
            title: "Вечеринка малого",
            circleColor: .addYellow,
            circleIcon: "gameController",
            currentCount: 9,
            totalCount: 20
        )
    }
}
