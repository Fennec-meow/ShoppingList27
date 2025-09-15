//
//  ListsView.swift
//  ShoppingList27
//
//  Created by Vladimir on 11.09.2025.
//

import SwiftUI

// MARK: - ListsMainView
struct ListsMainView: View {
    
    // MARK: - Private Properties
    
    @ObservedObject private var viewModel: ListsViewModel
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
            VStack {
                Spacer()
                EmptyListPlaceholderView()
                    .padding(.horizontal, 16)
                Spacer()
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
        ScrollView {
            LazyVStack(alignment: .center, spacing: 12) {
                ForEach(viewModel.lists) { list in
                    ListItemView(item: list)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
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
            .font(Fonts.semiBold28)
            .foregroundStyle(Color.grey80)
    }
    
    private var settingsMenu: some View {
        Menu("SettingsMenu",
             systemImage: ImageTitles.settingsMenu,
             content: { })
        .tint(Color.grey80)
    }
    
    // MARK: - Initializer
    
    init(viewModel: ListsViewModel) {
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
    enum Fonts {
        static let semiBold28: Font = .system(size: 28,
                                              weight: .semibold)
    }
}

// MARK: - Preview - Data
#Preview("Data") {
    let viewModel = ListsViewModel()
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
    let viewModel = ListsViewModel()
    return ListsMainView(viewModel: viewModel)
}
