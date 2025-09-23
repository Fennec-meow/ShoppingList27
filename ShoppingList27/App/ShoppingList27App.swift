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
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @StateObject private var listsMainVM = ListsMainViewModel()
    
    var body: some Scene {
        WindowGroup {
            RouteView(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
        .modelContainer(for: [
            ShoppingList.self,
            Product.self
        ])
    }
}
