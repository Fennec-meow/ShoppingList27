//
//  PlanningShoppingPlaceholderView.swift
//  ShoppingList27
//
//  Created by Алина on 04.09.2025.
//

import SwiftUI

// MARK: - EmptyListPlaceholderView

/// Плейсхолдер экрана "Давайте спланируем покупки".
/// Отображает картинку и текстовые подсказки, по центру экрана.
struct EmptyListPlaceholderView: View {
    
    var body: some View {
        VStack(spacing: 28) {
            imageContent
            textContent
        }
        .frame(alignment: .center)
    }
}

// MARK: - Subviews

private extension EmptyListPlaceholderView {
    
    var imageContent: some View {
        Image(Constants.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: 277)
    }
    
    var textContent: some View {
        VStack(spacing: 4) {
            headlineText
            supportingText
        }
        .frame(maxWidth: .infinity)
    }
    
    var headlineText: some View {
        makePlaceholderText(Constants.mainText, font: Font.Title3.medium)
    }
    
    var supportingText: some View {
        makePlaceholderText(Constants.subText, font: Font.Body.regular)
    }
    
    func makePlaceholderText(_ text: String, font: Font) -> some View {
        Text(text)
            .font(font)
            .foregroundColor(.grey80)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

// MARK: - Constants

private extension EmptyListPlaceholderView {
    
    enum Constants {
        static let mainText = "Давайте спланируем покупки!"
        static let subText = "Создайте свой первый список"
        static let image = "createList"
    }
}

// MARK: - Preview

struct PlanningShoppingPlaceholderViewPreviews: PreviewProvider {
    static var previews: some View {
        EmptyListPlaceholderView()
    }
}
