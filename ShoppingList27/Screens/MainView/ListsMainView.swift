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
    
    @Environment(NavigationRoute.self) private var router
    
    // MARK: - Body
    
    var body: some View {
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
                    .onTapGesture {
                        router.push(.productList(listItem: list))
                    }
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
            router.push(.listEditor(isEditing: false, listItem: nil))
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

// MARK: - Preview - Data
#Preview("Data") {
    let router = NavigationRoute()
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
        .environment(router)
}
