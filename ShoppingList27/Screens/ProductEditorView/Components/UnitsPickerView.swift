//
//  UnitsPickerView.swift
//  ShoppingList27
//
//  Created by Vladimir on 19.09.2025.
//

import SwiftUI

struct UnitsPickerView: View {
    
    @Binding private var selectedUnit: UnitOfMeasure
    
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
    
    private var titleLabel: some View {
        Text("Ед.изм.:")
            .font(.Body.regular)
            .foregroundStyle(.hint)
    }
    
    private var pickerView: some View {
        Picker("Unit Picker", selection: $selectedUnit) {
            ForEach(UnitOfMeasure.allCases) { unit in
                Text(unit.shortName)
            }
        }
        .pickerStyle(.menu)
        .tint(.uniTurquoise)
    }
    
    init(unit: Binding<UnitOfMeasure>) {
        self._selectedUnit = unit
    }
}

#Preview {
    @Previewable @State var unit: UnitOfMeasure = .piece
    Color.backgroundScreen
        .ignoresSafeArea()
        .overlay {
            UnitsPickerView(unit: $unit)
                .frame(width: 200)
        }
}
