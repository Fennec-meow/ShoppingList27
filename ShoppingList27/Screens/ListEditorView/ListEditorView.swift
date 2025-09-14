//
//  ListEditorView.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 14/09/2025.
//

import SwiftUI

/// Экран для создания новых списков и создания новых
struct ListEditorView: View {
    /// Флаг, определяющий режим работы экрана: true — редактирование, false — создание нового списка.
    let isEditing: Bool
    
    @State private var text: String = ""
    @State private var selectedColor: Color?
    @State private var selectedIcon: String?
    
    private var buttonTitle: String {
        isEditing ? "Сохранить" : "Создать"
    }
    private var isButtonEnabled: Bool {
        !text.isEmpty && selectedColor != nil && selectedIcon != nil
    }
    private let errorText = "Это название уже используется, пожалуйста, измените его."
    private let placeholder = "Введите название списка"
    
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                BaseTextField(
                    text: $text,
                    placeholder: placeholder,
                    hasError: false,
                    errorText: errorText
                )
                ColorPickerView(selectedColor: $selectedColor)
                DesignSelector(selectedIcon: $selectedIcon, selectionColor: selectedColor)
            }
            .padding(.top, 12)
            
            Spacer()
            
            BaseButton(isActive: isButtonEnabled, title: buttonTitle) {
                // Метод сохранения списка в БД
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 16)
    }
    
}

#Preview {
    ListEditorView(isEditing: false)
        .background(Color.backgroundScreen)
}
