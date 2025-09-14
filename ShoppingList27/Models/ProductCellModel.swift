//
//  ProductCellModel.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI
import Observation

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
final class ProductModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var isBought: Bool
    var count: Int
    var unitMeasure: UnitOfMeasure
    
    init(name: String, isBought: Bool, count: Int, unitMeasure: UnitOfMeasure) {
        self.name = name
        self.isBought = isBought
        self.count = count
        self.unitMeasure = unitMeasure
    }
    
    @MainActor static let mock1 = ProductModel(name: "Чайник", isBought: true, count: 2, unitMeasure: .piece)
    @MainActor static let mock2 = ProductModel(name: "Вода", isBought: false, count: 2, unitMeasure: .liter)
    @MainActor static let mock3 = ProductModel(name: "Макароны", isBought: false, count: 4, unitMeasure: .mlt)
}
