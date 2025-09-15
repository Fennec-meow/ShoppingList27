//
//  ProductCellModel.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

// Для выбора ед. изм. в дальнейшем
enum UnitOfMeasure: String, CaseIterable, Identifiable {
    case kilogram = "кг."
    case gram = "г."
    case liter = "л."
    case mlt = "мл."
    case piece = "шт."
    
    // Может понадобиться при создании для отображения в ForEach понадобится ID
    var id: String { rawValue }
    
    // Для вывода в текст
    var shortName: String { rawValue }
}

@Observable
final class Product: Identifiable {
    var id: UUID = UUID()
    var name: String
    var count: Int
    var unitMeasure: UnitOfMeasure
    private(set) var isBought: Bool
    
    init(
        name: String,
        count: Int,
        unitMeasure: UnitOfMeasure,
        isBought: Bool = false
    ) {
        self.name = name
        self.count = count
        self.unitMeasure = unitMeasure
        self.isBought = isBought
    }
    
    @MainActor static let mock1 = Product(name: "Чайник", count: 12, unitMeasure: .piece, isBought: true)
    @MainActor static let mock2 = Product(name: "Вода", count: 4, unitMeasure: .liter, isBought: false)
    @MainActor static let mock3 = Product(name: "Макароны", count: 2, unitMeasure: .kilogram, isBought: true)
    
    /// Для переключения чекбокса
    /// - Передаем параметр isBougth если явно хотим указать значение для этой переменной
    /// - Параметр можно не передавать если мы хотим просто переключить значение на противоположное
    func toggleBought(isBougth: Bool? = nil) {
        if let isBougth = isBougth {
            self.isBought = isBougth
        } else {
            self.isBought.toggle()
        }
    }
}
