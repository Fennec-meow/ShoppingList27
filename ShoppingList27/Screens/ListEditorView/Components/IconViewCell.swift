//
//  IconViewCell.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/10/25.
//

import SwiftUI

struct IconViewCell: View {
    var iconName: String
    var isSelected: Bool = false
    var selectedColor: Color
    
    static let height: CGFloat = 48
    static let width: CGFloat = 48
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? selectedColor : .backgroundIcon)
                .aspectRatio(contentMode: .fit)
                .frame(width: IconViewCell.width, height: IconViewCell.height)
            
            Image(iconName)
                .foregroundColor(isSelected ? .colorBackConstant : .colorWhite)
        }
    }
}
