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
        case listEditor(list: ShoppingList? = nil, registeredTitles: [String])
        case productList(list: ShoppingList)
        case createProduct
        
        var id: String {
            switch self {
            case .welcome: return "welcome"
            case .listMain: return "listMain"
            case .listEditor(let list, let registeredTitles):
                let listID = list.map { String(describing: $0.persistentModelID) } ?? "new"
                return "listEditor_\(listID)"
            case .productList(let list):
                return "productList_\(String(describing: list.persistentModelID))"
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
    func push(_ route: Route) {
        navigationPath.append(route)
    }
    /// Обработка возврата назад
    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
    /// Обработка перехода к корневому экрану
    func popToRoot() {
        guard !navigationPath.isEmpty else { return }
        navigationPath = []
    }
    /// Обработка замены текущего экрана
    func replaceCurrent(with route: Route) {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
        navigationPath.append(route)
    }
    
    /// Обработка показа модального окна
    func showSheet(_ route: Route) {
        presentingSheet = route
    }
    /// Обработка показа полноэкранного окна
    func showFullScreen(_ route: Route) {
        presentingFullScreen = route
    }
    /// Обработка закрытия всех модальных окон
    func dismissAllModals() {
        presentingSheet = nil
        presentingFullScreen = nil
        presentingModal = nil
        isPresented = nil
    }
}
