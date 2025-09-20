//
//  NavigationRoute.swift
//  ShoppingList27
//
//  Created by Алина on 16.09.2025.
//
import Observation
import SwiftUI

@MainActor
@Observable
final class NavigationRoute {
    enum Route: Hashable, Identifiable {
        case welcome
        case listMain
        case listEditor(isEditing: Bool, listItem: ListItem? = nil)
        case productList(listItem: ListItem)
        case createProduct
        
        var id: String {
            switch self {
            case .welcome: return "welcome"
            case .listMain: return "listMain"
            case .listEditor(let isEditing, let listItem):
                    return "listEditor_\(isEditing)_\(listItem?.id.uuidString ?? "new")"
            case .productList(let listItem):
                    return "productList_\(listItem.id.uuidString)"
            case .createProduct:
                    return "createProduct"
            }
        }
    }
    
    var navigationPath: [Route] = []
    var root: Route = .welcome
    /// Cвойства для модальных окон
    var presentingSheet: Route?
    var presentingFullScreen: Route?
    var presentingModal: Route?
    var isPresented: Route?
    
    /// Обработка навигации
    func handleNavigateTo(_ route: Route) {
        navigationPath.append(route)
    }
    /// Обработка возврата назад
    func handleGoBack() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
    /// Обработка перехода к корневому экрану
    func handleGoToRoot() {
        guard !navigationPath.isEmpty else { return }
        navigationPath = []
    }
    /// Обработка замены текущего экрана
    func handleReplaceCurrent(with route: Route) {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
        navigationPath.append(route)
    }
    
    /// Обработка показа модального окна
    func handlePresentSheet(_ route: Route) {
        presentingSheet = route
    }
    /// Обработка показа полноэкранного окна
    func handlePresentFullScreen(_ route: Route) {
        presentingFullScreen = route
    }
    /// Обработка закрытия всех модальных окон
    func handleDismissAllModals() {
        presentingSheet = nil
        presentingFullScreen = nil
        presentingModal = nil
        isPresented = nil
    }
}
