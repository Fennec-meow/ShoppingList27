//
//  DesignSelector.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/9/25.
//

import SwiftUI

struct DesignSelector: View {
    @Binding var selectedIcon: String
    
    var selectionColor: Color?
    
    private var titleText: String = "Выберите дизайн"
    private var titleFont = Font.system(size: 16, weight: .regular)
    
    init(selectedIcon: Binding<String>, selectionColor: Color?) {
        self._selectedIcon = selectedIcon
        self.selectionColor = selectionColor
    }
    
    var body: some View {
        mainView
            .background(Color.bgcolor)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
    }
    
    private var mainView: some View {
        VStack(alignment: .leading, spacing: 12) {
                title
            .padding(.horizontal, 12)
            iconsGrid
            .padding(.horizontal, 4)
        }
        .padding(.vertical, 12)
    }
    
    private var title: some View {
        Text(titleText)
            .font(titleFont)
            .foregroundColor(.grey80)
    }
    
    private var iconsGrid: some View {
        makeVGrid(columnsCount: 6)
    }
    
    private func selectIcon(_ iconName: String) {
        selectedIcon = iconName
    }
    
    private func makeColumns(count: Int,
                             spacingBetweenColumns spacing: CGFloat = 0,
                             maxColumnWidth width: CGFloat) -> [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 48), spacing: spacing), count: count)
    }
    
    private func makeVGrid(columnsCount: Int,
                           spacingBetweenColumns: CGFloat = 0,
                           maxColumnWidth: CGFloat = 48) -> some View {
        LazyVGrid(columns: makeColumns(count: columnsCount,
                                       spacingBetweenColumns: spacingBetweenColumns,
                                       maxColumnWidth: maxColumnWidth),
                  alignment: .center,
                  spacing: 12) {

            ForEach(Icons.allCases, id: \.self) { icon in
                let iconName = icon.rawValue
                Button {
                    selectIcon(iconName)
                } label: {
                    IconViewCell(iconName: iconName,
                                 isSelected: iconName == selectedIcon,
                                 selectedColor: selectionColor ?? .backgroundIcon.opacity(0.5)
                    )
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selection: String = ""
    let selectionColor: Color? = .addGreen

    VStack {
        ZStack {
            Color.backgroundScreen
            DesignSelector(selectedIcon: $selection, selectionColor: selectionColor)
                .padding(16)
        }
        .colorScheme(.light)
        ZStack {
            Color.backgroundScreen
            DesignSelector(selectedIcon: $selection, selectionColor: selectionColor)
                .padding(16)
        }
        .colorScheme(.dark)
    }
    .ignoresSafeArea()
    
    .onChange(of: selection) {
        print(selection)
    }
}
