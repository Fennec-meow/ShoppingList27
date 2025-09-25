//
//  ListEditorView.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 14/09/2025.
//

import SwiftUI
import SwiftData

// MARK: - ListEditorView

/// Экран для создания новых списков и создания новых
struct ListEditorView: View {
    
    // MARK: Private Properties
    
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationRoute.self) private var router
    
    @State private var text: String
    @State private var selectedColor: Color?
    @State private var selectedIcon: String?
    
    private let buttonTitle: String
    private let errorText = "Это название уже используется, пожалуйста, измените его."
    private let placeholder = "Введите название списка"
    private let shoppingList: ShoppingList?
    private let registeredTitles: [String]
    
    // MARK: Body
    
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
    
    // MARK: Initializer
    
    init(shoppingList: ShoppingList? = nil, registeredTitles: [String]) {
        text = shoppingList?.title ?? ""
        selectedColor = shoppingList?.circleColor
        selectedIcon = shoppingList?.circleIcon
        self.shoppingList = shoppingList
        buttonTitle = shoppingList == nil ? "Создать" : "Сохранить"
        self.registeredTitles = registeredTitles
    }
}

// MARK: - Private Properties

private extension ListEditorView {
    
    var isEditing: Bool {
        shoppingList != nil
    }
    
    var isButtonEnabled: Bool {
        !text.isEmpty && selectedColor != nil && selectedIcon != nil && !textFieldHasError
    }
    
    var textFieldHasError: Bool {
        if let shoppingList {
            registeredTitles.contains(text) && text != shoppingList.title
        } else {
            registeredTitles.contains(text)
        }
    }
}
// MARK: - Subviews

private extension ListEditorView {
    
    var propertiesEditor: some View {
        VStack(spacing: 24) {
            BaseTextField(
                text: $text,
                placeholder: placeholder,
                hasError: textFieldHasError,
                errorText: errorText
            )
            ColorPickerView(selectedColor: $selectedColor)
            DesignSelector(selectedIcon: $selectedIcon, selectionColor: selectedColor)
        }
    }
    
    var saveButton: some View {
        BaseButton(isActive: isButtonEnabled, title: buttonTitle) {
            applyChanges()
            router.pop()
        }
    }
    
    var backButton: some View {
        Button {
            router.pop()
        } label: {
            Image(systemName: "chevron.backward")
        }
        .tint(.grey80)
    }
    
    var toolbarTitle: some View {
        HStack(spacing: .zero) {
            Text(isEditing ? "Редактировать список" : "Создать список")
                .font(Font.Headline.medium)
                .foregroundStyle(.grey80)
            Spacer()
        }
    }
}

// MARK: - Private Methods

private extension ListEditorView {
    
    func applyChanges() {
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
        do {
            try modelContext.save()
        } catch {
            print("ListEditorView.applyChanges: save error \(error)")
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ListEditorView(shoppingList: nil, registeredTitles: ["123"])
            .environment(NavigationRoute())
    }
}
