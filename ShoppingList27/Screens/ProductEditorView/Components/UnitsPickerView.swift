//
//  UnitsPickerView.swift
//  ShoppingList27
//
//  Created by Vladimir on 19.09.2025.
//

import SwiftUI

// MARK: - UnitsPickerView

struct UnitsPickerView: View {
    
    @Binding private var selectedUnit: Product.UnitOfMeasure
    
    var body: some View {
        HStack {
            titleLabel
            Spacer()
            pickerView
        }
        .padding([.leading, .vertical], 16)
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color.bgcolor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: Initializer

    init(unit: Binding<Product.UnitOfMeasure>) {
        self._selectedUnit = unit
    }
}

// MARK: - Subviews

private extension UnitsPickerView {
    var titleLabel: some View {
        Text("Ед.изм.:")
            .font(.Body.regular)
            .foregroundStyle(.hint)
    }
    
    var pickerView: some View {
        Picker("Unit Picker", selection: $selectedUnit) {
            ForEach(Product.UnitOfMeasure.allCases) { unit in
                Text(unit.shortName)
            }
        }
        .pickerStyle(.menu)
        .tint(.uniTurquoise)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var unit: Product.UnitOfMeasure = .piece
    Color.backgroundScreen
        .ignoresSafeArea()
        .overlay {
            UnitsPickerView(unit: $unit)
                .frame(width: 200)
        }
}
