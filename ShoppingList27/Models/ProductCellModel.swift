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

struct ProductCellModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var isBought: Bool
    var count: Int
    var unitMeasure: UnitOfMeasure
    
    static let mock1 = ProductCellModel(name: "Чайник", isBought: true, count: 2, unitMeasure: .piece)
    static let mock2 = ProductCellModel(name: "Вода", isBought: false, count: 2, unitMeasure: .liter)
    static let mock3 = ProductCellModel(name: "Макароны", isBought: false, count: 4, unitMeasure: .mlt)
}
