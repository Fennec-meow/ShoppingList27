//
//  ColorComponents.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 18/09/2025.
//

import SwiftUI

/// Хелпер  для хранения и восстановления Color в SwiftData.
struct ColorComponents: Codable {
    let red: Float
    let green: Float
    let blue: Float
    
    // Собираем Color для UI
    var color: Color {
        Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
    
    // Разбираем Color на RGB для сохранения
    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        self.red = Float(red)
        self.green = Float(green)
        self.blue = Float(blue)
    }
}
