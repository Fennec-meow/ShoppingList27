//
//  ProductEditorView.swift
//  ShoppingList27
//
//  Created by Vladimir on 19.09.2025.
//

import SwiftUI

// MARK: - ProductEditorView
struct ProductEditorView: View {
    
    // MARK: - Private Properties
    
    @Environment(\.dismiss) private var dismiss
    private let saveAction: (String, Int, UnitOfMeasure) -> Void
    private let pageTitle: String
    private let registeredNames: [String]
    
    // MARK: - Private Properties - State
    
    @State private var productName: String = ""
    @State private var count: Int?
    @State private var unit: UnitOfMeasure = .piece

    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.backgroundScreen
                .ignoresSafeArea()
            content
        }
    }
    
    // MARK: - Private Properties - Computed
    
    private var isSaveEnabled: Bool {
        if let count,
           count > 0,
           !productName.isEmpty,
           !isProductNameDuplicated {
            true
        } else {
            false
        }
    }
    
    private var isProductNameDuplicated: Bool {
        registeredNames.contains(productName)
    }
    
    // MARK: - Subviews
    
    private var content: some View {
        VStack(spacing: 12) {
            dragIndicator
            topBar
            propertiesSetterView
            Spacer()
        }
        .padding(.top, 4)
    }
    
    private var propertiesSetterView: some View {
        VStack(spacing: 20) {
            productNameTextField
            HStack(spacing: 16) {
                countTextField
                UnitsPickerView(unit: $unit)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    private var productNameTextField: some View {
        BaseTextField("Product Name",
                      text: $productName,
                      placeholder: "Название товара",
                      errorText: isProductNameDuplicated ? "Этот товар уже есть в списке, добавьте другой" : nil,
                      keyboardType: .default)
    }
    
    private var countTextField: some View {
        BaseTextField("Product Count",
                      value: $count,
                      format: .number,
                      placeholder: "Количество",
                      keyboardType: .numberPad)
    }
    
    private var topBar: some View {
        HStack {
            cancelButton
                .padding(.horizontal, 16)
            Spacer()
            pageTitleView
            Spacer()
            doneButton
                .padding(.horizontal, 16)
        }
    }
    
    private var pageTitleView: some View {
        Text(pageTitle)
            .foregroundStyle(.grey80)
            .font(.Headline.semiBold)
    }
    
    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Отменить")
                .font(.Body.regular)
        }
        .tint(.uniTurquoise)
    }
    
    private var doneButton: some View {
        Button {
            if let count, isSaveEnabled {
                saveAction(productName, count, unit)
            }
            dismiss()
        } label: {
            Text("Готово")
                .font(.Headline.semiBold)
        }
        .tint(isSaveEnabled ? .uniTurquoise : .hint)
        .disabled(!isSaveEnabled)
    }
    
    private var dragIndicator: some View {
        Color.uniGrey
            .frame(width: 36, height: 5)
            .clipShape(RoundedRectangle(cornerRadius: 2.5))
    }
    
    init(product: Product?, registeredNames: [String] = [], onSave: @escaping (String, Int, UnitOfMeasure) -> Void) {
        saveAction = onSave
        if let product {
            productName = product.name
            count = product.count
            unit = product.unitMeasure
            pageTitle = "Редактировать"
            self.registeredNames = registeredNames.filter { $0 != product.name }
        } else {
            pageTitle = "Создание товара"
            self.registeredNames = registeredNames
        }
    }
    
}

// MARK: - Previews

#Preview("Create New Product") {
    @Previewable @State var isShown: Bool = false
    Button("Show modal view") {
        isShown = true
    }
    .sheet(isPresented: $isShown) {
        ProductEditorView(product: nil,
                          registeredNames: ["Текст", "Ошибка"]) { name, count, unit in
            let newProduct = Product(name: name,
                                     count: count,
                                     unitMeasure: unit,
                                     isBought: false)
            print("Save \(newProduct)")
        }
    }
}

#Preview("Edit Product") {
    @Previewable @State var product = Product(name: "Чайник",
                                              count: 1,
                                              unitMeasure: .piece)
    @Previewable @State var isShown: Bool = false
    Button("Show modal view") {
        isShown = true
    }
    .sheet(isPresented: $isShown) {
        ProductEditorView(product: product,
                          registeredNames: ["Текст", "Ошибка", "Чайник"]) { name, count, unit in
            product.name = name
            product.count = count
            product.unitMeasure = unit
            print("Save \(product)")
        }
    }
}
