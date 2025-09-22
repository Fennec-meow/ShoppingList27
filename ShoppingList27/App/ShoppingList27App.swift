//
//  ShoppingList27App.swift
//  ShoppingList27
//
//  Created by Nikita Tsomuk on 01.09.2025.
//

import SwiftUI

@main
struct ShoppingList27App: App {
    @AppStorage("hasCompleteOnboarding") private var hasCompleteOnboarding = false
    @AppStorage("ThemeType") private var selectedThemeType: ThemeType = .system
    @StateObject private var listsMainVM = ListsMainViewModel()
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some Scene {
        WindowGroup {
            Group {
                if hasCompleteOnboarding {
                    ListsMainView(viewModel: listsMainVM)
                } else {
                    WelcomeScreenView(hasCompletedOnboarding: $hasCompleteOnboarding)
                }
            }
            .environment(\.colorScheme,
                  selectedThemeType == .system
                  ? systemColorScheme
                  : (selectedThemeType == .light ? .light : .dark)
            )
        }
    }
}
