//
//  ListItem.swift
//  ShoppingList27
//
//  Created by Hajime4life on 07.09.2025.
//

import SwiftUI
 
struct ShoppingList: Identifiable {
    // удалить, перевести List на title(он уникальный)
    let id: UUID
    var title: String      // ✅
    var circleColor: Color // ✅
    var circleIcon: String // ✅
    var currentCount: Int  // Общее кол-во Product, отмеченных как купленные
    var totalCount: Int    // Общее кол-во добавленных Product
    
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
}
