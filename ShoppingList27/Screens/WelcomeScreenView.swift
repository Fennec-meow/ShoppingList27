//
//  WelcomeScreenView.swift
//  ShoppingList27
//
//  Created by Viktor Zavhorodnii on 07/09/2025.
//

import SwiftUI

struct WelcomeScreenView: View {
    @Binding var hasCompletedOnboarding: Bool
    
    private enum Strings {
        static let header = "Добро пожаловать!"
        static let headline = "Никогда не забывайте,\nчто нужно купить"
        static let subHeadline = "Создавайте списки\nи не переживайте о покупках"
        static let buttonTitle = "Начать"
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 48) {
                Text(Strings.header)
                    .font(.system(size: 41))
                    .lineLimit(1)
                    .minimumScaleFactor(0.9)
                    .padding(.top, 40)
                
                Image(.welcome)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 277)
                
                VStack(spacing: 12) {
                    Text(Strings.headline)
                        .font(.system(size: 28, weight: .semibold))
                    
                    Text(Strings.subHeadline)
                        .font(.system(size: 22))
                }
                .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            BaseButton(title: Strings.buttonTitle) {
                hasCompletedOnboarding = true
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 16)
        .background(.backgroundScreen)
    }
}

#Preview {
    @Previewable @State var hasCompletedOnboarding = false
    WelcomeScreenView(hasCompletedOnboarding: $hasCompletedOnboarding)
}
