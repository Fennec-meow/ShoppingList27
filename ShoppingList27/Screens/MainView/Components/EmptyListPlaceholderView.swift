//
//  PlanningShoppingPlaceholderView.swift
//  ShoppingList27
//
//  Created by Алина on 04.09.2025.
//

import SwiftUI

/// Плейсхолдер экрана "Давайте спланируем покупки".
/// Отображает картинку и текстовые подсказки, по центру экрана.
struct EmptyListPlaceholderView: View {
    
    private enum Constants {
        static let mainText = "Давайте спланируем покупки!"
        static let subText = "Создайте свой первый список"
        static let image = "createList"
    }
    
    private let title3Medium = Font.system(size: 20, weight: .medium)
    private let regular17 = Font.system(size: 17, weight: .regular)
    
    var body: some View {
            VStack(spacing: 28) {
                imageContent
                textContent
            }
            .frame(alignment: .center)
    }
    
    private var imageContent: some View {
        Image(Constants.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: 277)
    }
    
    private var textContent: some View {
        VStack(spacing: 4) {
            headlineText
            supportingText
        }
        .frame(maxWidth: .infinity)
    }
    
    private var headlineText: some View {
        makePlaceholderText(Constants.mainText, font: title3Medium)
    }
    
    private var supportingText: some View {
        makePlaceholderText(Constants.subText, font: regular17)
    }
    
    private func makePlaceholderText(_ text: String, font: Font) -> some View {
        Text(text)
            .font(font)
            .foregroundColor(.grey80)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

// MARK: - Preview
struct PlanningShoppingPlaceholderViewPreviews: PreviewProvider {
    static var previews: some View {
        EmptyListPlaceholderView()
    }
}
