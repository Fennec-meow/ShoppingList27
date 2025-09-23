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
    
    private let shoppingList: ShoppingList?
    
    @State private var text: String
    @State private var selectedColor: Color?
    @State private var selectedIcon: String?
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationRoute.self) private var router
    
    private var isEditing: Bool {
        shoppingList != nil
    }
    
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                toolbarTitle
            }
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
    }
    
}

#Preview {
    NavigationStack {
        ListEditorView(shoppingList: nil)
            .environment(NavigationRoute())
    }
}
