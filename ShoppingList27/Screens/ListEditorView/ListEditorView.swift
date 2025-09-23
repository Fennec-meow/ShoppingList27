//
//  ListEditorView.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 14/09/2025.
//

import SwiftUI
import SwiftData

/// Экран для создания новых списков и создания новых
struct ListEditorView: View {
    
    // MARK: - Private Properties
    
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationRoute.self) private var router
    
    private var buttonTitle: String
    private let errorText = "Это название уже используется, пожалуйста, измените его."
    private let placeholder = "Введите название списка"
    private let shoppingList: ShoppingList?
    
    // MARK: - Private Properties - State
    
    @State private var text: String
    @State private var selectedColor: Color?
    @State private var selectedIcon: String?
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: .zero) {
            propertiesEditor
            Spacer()
            saveButton
        }
        .padding(.bottom, 20)
        .padding(.top, 12)
        .padding(.horizontal, 16)
        .background(Color.backgroundScreen)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                toolbarTitle
            }
        }
    }
    
    // MARK: - Private Properties - Computed
    
    private var isEditing: Bool {
        shoppingList != nil
    }
    
    private var isButtonEnabled: Bool {
        !text.isEmpty && selectedColor != nil && selectedIcon != nil
    }
    
    // MARK: - Subviews
    
    private var propertiesEditor: some View {
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
    }
    
    private var saveButton: some View {
        BaseButton(isActive: isButtonEnabled, title: buttonTitle) {
            guard let selectedColor, let selectedIcon else { return }
            if isEditing {
                shoppingList?.title = text
                shoppingList?.circleColor = selectedColor
                shoppingList?.circleIcon = selectedIcon
            } else {
                let newList = ShoppingList(
                    title: text,
                    circleColor: selectedColor,
                    circleIcon: selectedIcon
                )
                modelContext.insert(newList)
            }
            try? modelContext.save()
            router.pop()
        }
    }
    
    private var backButton: some View {
        Button {
            router.pop()
        } label: {
            Image(systemName: "chevron.backward")
        }
        .tint(.grey80)
    }
    
    private var toolbarTitle: some View {
        HStack(spacing: .zero) {
            Text(isEditing ? "Редактировать список" : "Создать список")
                .font(Font.Headline.medium)
                .foregroundStyle(.grey80)
            Spacer()
        }
    }
    
    init(shoppingList: ShoppingList? = nil) {
        text = shoppingList?.title ?? ""
        selectedColor = shoppingList?.circleColor
        selectedIcon = shoppingList?.circleIcon
        self.shoppingList = shoppingList
        buttonTitle = shoppingList == nil ? "Создать" : "Сохранить"
    }
    
}

#Preview {
    NavigationStack {
        ListEditorView(shoppingList: nil)
            .environment(NavigationRoute())
    }
}
