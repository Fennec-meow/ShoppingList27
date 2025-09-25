//
//  ProductCellModel.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI
import SwiftData

@Model
final class Product {
    var name: String
    var count: Int
    var unitMeasure: UnitOfMeasure
    var isBought: Bool
    
    @Relationship var shoppingList: ShoppingList?
    
    init(
        name: String,
        count: Int,
        unitMeasure: UnitOfMeasure,
        isBought: Bool = false,
        list: ShoppingList
    ) {
        self.name = name
        self.count = count
        self.unitMeasure = unitMeasure
        self.isBought = isBought
        self.shoppingList = list
    }
}

extension Product {
    enum UnitOfMeasure: String, Codable, CaseIterable, Identifiable {
        
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
        var id: Self { self }
    }
}
