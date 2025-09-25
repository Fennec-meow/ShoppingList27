//
//  ProductEditorView.swift
//  ShoppingList27
//
//  Created by Vladimir on 19.09.2025.
//

import SwiftUI

// MARK: - ProductEditorView

struct ProductEditorView: View {
    
    // MARK: Private Properties
    
    @Environment(NavigationRoute.self) private var router
    @Environment(\.modelContext) private var modelContext
    
    @State private var productName: String = ""
    @State private var count: Int?
    @State private var unit: Product.UnitOfMeasure = .piece
    
    private let pageTitle: String
    private let registeredNames: [String]
    
    private let shoppingList: ShoppingList
    private let product: Product?
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: 12) {
            dragIndicator
            topBar
            propertiesSetterView
            Spacer()
        }
        .padding(.top, 4)
        .background(.backgroundScreen)
    }
    
    // MARK: Initializer
    
    init(product: Product?, shoppingList: ShoppingList) {
        self.product = product
        self.shoppingList = shoppingList
        let registeredNames = shoppingList.productList.map { $0.name }
        
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

// MARK: - Private Properties

private extension ProductEditorView {
    
    var isSaveEnabled: Bool {
        if let count,
           count > 0,
           !productName.isEmpty,
           !isProductNameDuplicated {
            true
        } else {
            false
        }
    }
    
    var isProductNameDuplicated: Bool {
        registeredNames.contains(productName)
    }
}

// MARK: - Subviews

private extension ProductEditorView {
    
    var propertiesSetterView: some View {
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
    
    var productNameTextField: some View {
        BaseTextField(
            "Product Name",
            text: $productName,
            placeholder: "Название товара",
            errorText: isProductNameDuplicated ? "Этот товар уже есть в списке, добавьте другой" : nil,
            keyboardType: .default
        )
    }
    
    var countTextField: some View {
        BaseTextField(
            "Product Count",
            value: $count,
            format: .number,
            placeholder: "Количество",
            keyboardType: .numberPad
        )
    }
    
    var topBar: some View {
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
    
    var pageTitleView: some View {
        Text(pageTitle)
            .foregroundStyle(.grey80)
            .font(.Headline.semiBold)
    }
    
    var cancelButton: some View {
        Button {
            router.dismissAllModals()
        } label: {
            Text("Отменить")
                .font(.Body.regular)
        }
        .tint(.uniTurquoise)
    }
    
    var doneButton: some View {
        Button {
            if let count, isSaveEnabled {
                saveAction(productName, count, unit)
            }
            router.dismissAllModals()
        } label: {
            Text("Готово")
                .font(.Headline.semiBold)
        }
        .tint(isSaveEnabled ? .uniTurquoise : .hint)
        .disabled(!isSaveEnabled)
    }
    
    var dragIndicator: some View {
        Color.uniGrey
            .frame(width: 36, height: 5)
            .clipShape(RoundedRectangle(cornerRadius: 2.5))
    }
    
    func saveAction(_ name: String, _ count: Int, _ unit: Product.UnitOfMeasure) {
        if let product {
            product.name = name
            product.count = count
            product.unitMeasure = unit
        } else {
            let product = Product(
                name: name,
                count: count,
                unitMeasure: unit,
                list: shoppingList
            )
            modelContext.insert(product)
        }
        do {
            try modelContext.save()
        } catch {
            print("Something went wrong")
        }
    }
}

// MARK: - Previews - Create New Product

#Preview("Create New Product") {
    @Previewable @State var isShown: Bool = false
    let list = ShoppingList(
        title: "List",
        circleColor: .addBlue,
        circleIcon: Icons.alert.rawValue
    )
    Button("Show modal view") {
        isShown = true
    }
    .sheet(isPresented: $isShown) {
        ProductEditorView(product: nil, shoppingList: list)
    }
}

// MARK: - Preview - Edit Product

#Preview("Edit Product") {
    @Previewable @State var isShown: Bool = false
    @Previewable @State var product = Product(
        name: "Чайник",
        count: 1,
        unitMeasure: .piece,
        list: ShoppingList(
            title: "List",
            circleColor: .addBlue,
            circleIcon: Icons.alert.rawValue
        )
    )
    
    let list = ShoppingList(
        title: "List",
        circleColor: .addBlue,
        circleIcon: Icons.alert.rawValue
    )
    Button("Show modal view") {
        isShown = true
    }
    .sheet(isPresented: $isShown) {
        ProductEditorView(
            product: product,
            shoppingList: list
        )
    }
}
