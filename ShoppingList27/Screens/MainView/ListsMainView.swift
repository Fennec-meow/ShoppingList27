//
//  ListsMainView.swift
//  ShoppingList27
//
//  Created by Vladimir on 11.09.2025.
//

import SwiftUI

// MARK: - ListsMainView
struct ListsMainView: View {
    
    // MARK: - Private Properties
    
    @ObservedObject private var viewModel: ListsMainViewModel
    @State private var isCreatingNewList: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundScreen
                    .ignoresSafeArea()
                content
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    titleView
                }
                ToolbarItem(placement: .topBarTrailing) {
                    settingsMenu
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var content: some View {
        if viewModel.shouldDisplayPlaceholder {
            EmptyListPlaceholderView()
                .padding(.horizontal, 16)
                .frame(maxHeight: .infinity)
                .safeAreaInset(edge: .bottom) {
                    createListButton
                }
        } else {
            listsScrollView
                .safeAreaInset(edge: .bottom) {
                    createListButton
                }
        }
    }
    
    private var listsScrollView: some View {
        List {
            ForEach(viewModel.lists) { list in
                ListItemView(item: list)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.backgroundScreen)
        }
        .listRowSpacing(12)
        .safeAreaPadding(.top, 12) // for top spacing
        .safeAreaPadding(.leading, 16) // for swipe actions
        .padding(.trailing, 16) // for swipe actions
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
    
    private var createListButton: some View {
        BaseButton(title: Strings.createList,
                   action: {
            print("CreatingNewList")
            isCreatingNewList = true
        })
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    private var titleView: some View {
        Text(Strings.title)
            .font(.Title1.semiBold)
            .foregroundStyle(Color.grey80)
    }
    
    private var settingsMenu: some View {
        Menu("SettingsMenu",
             systemImage: ImageTitles.settingsMenu,
             content: { })
        .tint(Color.grey80)
    }
    
    // MARK: - Initializer
    
    init(viewModel: ListsMainViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - Extension - Constants
private extension ListsMainView {
    enum Strings {
        static let title = "Мои списки"
        static let createList = "Создать список"
    }
    enum ImageTitles {
        static let settingsMenu = "ellipsis.circle"
    }
}

// MARK: - Theme Types
// TODO: - Я думаю уже пора переносить enums куда-то в одно место
enum ThemeType: String, CaseIterable {
    case system, dark, light
}

// MARK: - Preview - Data
#Preview("Data") {
    let viewModel = ListsMainViewModel()
    viewModel.insert(list: .mock)
    viewModel.insert(list: .mock2)
    viewModel.insert(list: .mock3)
    viewModel.insert(list: .mock)
    viewModel.insert(list: .mock2)
    viewModel.insert(list: .mock3)
    viewModel.insert(list: .mock)
    viewModel.insert(list: .mock2)
    viewModel.insert(list: .mock3)
    return ListsMainView(viewModel: viewModel)
}

// MARK: - Preview - Empty
#Preview("Empty") {
    let viewModel = ListsMainViewModel()
    return ListsMainView(viewModel: viewModel)
}
