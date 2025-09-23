//
//  ListItem.swift
//  ShoppingList27
//
//  Created by Hajime4life on 07.09.2025.
//

import SwiftUI
import SwiftData

@Model
final class ShoppingList {
    @Attribute(.unique) var title: String
    var circleIcon: String
    var circleColorValue: ColorComponents
    
    @Relationship(deleteRule: .cascade, inverse: \Product.shoppingList)
    var productList: [Product] = []
    
    var circleColor: Color {
        get { circleColorValue.color }
        set { circleColorValue = ColorComponents(color: newValue) }
    }
    
    var currentCount: Int { productList.count(where: { $0.isBought}) }
    var totalCount: Int { productList.count }
    
    init(
        title: String,
        circleColor: Color,
        circleIcon: String,
    ) {
        self.title = title
        self.circleColorValue = ColorComponents(color: circleColor)
        self.circleIcon = circleIcon
    }
}

extension ShoppingList: Equatable, Hashable {
    
}
