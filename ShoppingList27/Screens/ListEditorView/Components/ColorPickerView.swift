//
//  ColorPickerView.swift
//  ShoppingList27
//
//  Created by Alesia Matusevich on 08/09/2025.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var selectedColor: Color?
    
    let colors: [Color] = [.addGreen, .addPurple, .addBlue, .addRed, .addYellow]
    let title: String = "Выберите цвет"
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12)
            HStack(spacing: 0) {
                Spacer()
                ForEach(colors, id: \.self) { color in
                    ZStack {
                        if selectedColor == color {
                            Circle()
                                .stroke(.uniTurquoise, lineWidth: 2)
                                .frame(width: 48, height: 48)
                        }
                        Circle()
                            .fill(color)
                            .frame(width: 40, height: 40)
                    }
                    .frame(width: 48, height: 48)
                    .contentShape(Circle())
                    .onTapGesture {
                        selectedColor = (selectedColor == color) ? nil : color
                    }
                    Spacer()
                }
            }
        }
        .padding(12)
        .background(.bgcolor)
        .cornerRadius(12)
    }
}

#Preview {
    @Previewable @State var selectedColor: Color?
    return ColorPickerView(selectedColor: $selectedColor)
}
