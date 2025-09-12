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
    
    var body: some Scene {
        WindowGroup {
            if hasCompleteOnboarding {
                ContentView()
            } else {
                WelcomeScreenView(hasCompletedOnboarding: $hasCompleteOnboarding)
            }
        }
    }
}
