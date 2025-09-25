//
//  ShoppingList27App.swift
//  ShoppingList27
//
//  Created by Nikita Tsomuk on 01.09.2025.
//

import SwiftUI
import SwiftData

@main
struct ShoppingList27App: App {
    @AppStorage("hasCompleteOnboarding") private var hasCompleteOnboarding = false
    @AppStorage("ThemeType") private var selectedThemeType: ThemeType = .system
    @StateObject private var listsMainVM = ListsMainViewModel()
    
    var body: some Scene {
        WindowGroup {
            RouteView(hasCompletedOnboarding: $hasCompleteOnboarding)
                .preferredColorScheme(
                    selectedThemeType == .system
                    ? nil
                    : (selectedThemeType == .light ? .light : .dark)
                )
        }
        .modelContainer(for: [
            ShoppingList.self,
            Product.self
        ])
    }
}

// TODO: - Я думаю уже пора переносить enums куда-то в одно место
enum ThemeType: String, CaseIterable {
    case system, dark, light
}
