//
//  ProductCellModel.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

@Observable
final class Product: Identifiable {
    enum UnitOfMeasure: String {
        
        /// Используем типичные значения для записи в БД, чтобы не было конфликтов при миграции
        case kilogram = "kg"
        case gram = "g"
        case liter = "l"
        case milliliter = "ml"
        case piece = "pcs"
        
        /// Управляем отображением для UI через computed property
        var shortName: String {
            switch self {
            case .kilogram: return "кг."
            case .gram: return "г."
            case .liter: return "л."
            case .milliliter: return "мл."
            case .piece: return "шт."
            }
        }
    }
    
    var id: UUID = UUID()
    var name: String                // ✅
    var count: Int                  // ✅ Кол-во выбранное для покупки
    var unitMeasure: UnitOfMeasure  // ✅ Единицы измерения выбранные при записи 
    private(set) var isBought: Bool // ✅
    
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
