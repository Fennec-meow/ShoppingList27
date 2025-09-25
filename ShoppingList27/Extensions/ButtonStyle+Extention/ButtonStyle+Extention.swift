//
//  ButtonStyle+Extention.swift
//  ShoppingList27
//
//  Created by Hajime4Life on 10.09.2025.
//

import SwiftUI

extension ButtonStyle where Self == CheckboxStyle {
    static func checkbox(isChecked: Bool) -> CheckboxStyle {
        CheckboxStyle(isChecked: isChecked)
    }
}
