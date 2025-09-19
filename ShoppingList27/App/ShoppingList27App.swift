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
    @StateObject private var listsMainVM = ListsMainViewModel()
    var body: some Scene {
        WindowGroup {
            if hasCompleteOnboarding {
                ListsMainView(viewModel: listsMainVM)
            } else {
                WelcomeScreenView(hasCompletedOnboarding: $hasCompleteOnboarding)
            }
        }
        .modelContainer(for: [
            ShoppingList.self,
            Product.self
        ])
    }
}
