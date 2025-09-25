//
//  DesignSelector.swift
//  ShoppingList27
//
//  Created by Owi Lover on 9/9/25.
//

import SwiftUI

// MARK: - DesignSelector

struct DesignSelector: View {
    
    // MARK: Properties
    
    @Binding var selectedIcon: String?
    let selectionColor: Color?
    
    private let titleText: String = "Выберите дизайн"
    private let titleFont = Font.system(size: 16, weight: .regular)
    
    var body: some View {
        mainView
            .background(Color.bgcolor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Subviews

private extension DesignSelector {
    
    var mainView: some View {
        VStack(alignment: .leading, spacing: 12) {
            title
                .padding(.horizontal, 12)
            iconsGrid
                .padding(.horizontal, 4)
        }
        .padding(.vertical, 12)
    }
    
    var title: some View {
        Text(titleText)
            .font(titleFont)
            .foregroundColor(.grey80)
    }
    
    var iconsGrid: some View {
        makeVGrid(columnsCount: 6)
    }
}

// MARK: - Private Methods

private extension DesignSelector {
    func selectIcon(_ iconName: String) {
        selectedIcon = iconName
    }
    
    func makeColumns(
        count: Int,
        spacingBetweenColumns spacing: CGFloat = 0,
        maxColumnWidth width: CGFloat
    ) -> [GridItem] {
        
        Array(repeating: GridItem(.flexible(minimum: 48), spacing: spacing), count: count)
    }
    
    func makeVGrid(
        columnsCount: Int,
        spacingBetweenColumns: CGFloat = 0,
        maxColumnWidth: CGFloat = 48
    ) -> some View {
        
        LazyVGrid(
            columns: makeColumns(
                count: columnsCount,
                spacingBetweenColumns: spacingBetweenColumns,
                maxColumnWidth: maxColumnWidth
            ),
            alignment: .center,
            spacing: 12
        ) {
            
            ForEach(Icons.allCases, id: \.self) { icon in
                let iconName = icon.rawValue
                Button {
                    selectIcon(iconName)
                } label: {
                    IconViewCell(
                        iconName: iconName,
                        isSelected: iconName == selectedIcon,
                        selectedColor: selectionColor ?? .backgroundIcon.opacity(0.5)
                    )
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var selection: String?
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
}
