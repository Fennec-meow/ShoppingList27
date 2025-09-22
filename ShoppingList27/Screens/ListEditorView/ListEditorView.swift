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
    let listItem: ListItem?
    
    @State private var text: String = ""
    @State private var selectedColor: Color?
    @State private var selectedIcon: String?
    
    @Environment(NavigationRoute.self) private var router
    
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
                router.pop()
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 16)
        .background(Color.backgroundScreen)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
        
        private var backButton: some View {
            Button {
                router.pop()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.backward")
                    Text(isEditing ? "Редактировать список" : "Создать список")
                        .font(Font.Headline.medium)
                }
            }
            .tint(.grey80)
        }
    }

#Preview {
    NavigationStack {
        ListEditorView(isEditing: false, listItem: nil)
            .environment(NavigationRoute())
    }
}
