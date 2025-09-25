//
//  ListsMainView.swift
//  ShoppingList27
//
//  Created by Vladimir on 11.09.2025.
//

import SwiftUI
import SwiftData

// MARK: - ListsMainView
struct ListsMainView: View {
    @Query private var lists: [ShoppingList]
    // MARK: - Private Properties
    
    @ObservedObject private var viewModel: ListsMainViewModel
    @State private var isCreatingNewList: Bool = false
    @AppStorage("ThemeType") private var selectedThemeType: ThemeType = .system
    @Environment(\.colorScheme) private var colorScheme
    
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
        if lists.isEmpty {
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
            ForEach(lists) { list in
                ListItemView(item: list)
                    .onTapGesture {
                        router.push(.productList(list: list))
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
            router.push(.listEditor(list: nil, registeredTitles: []))
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
        Menu {
            Picker(
                selection: $selectedThemeType,
                label: Label("Установить тему", systemImage: colorScheme == .dark
                             ? ImageTitles.themeDark
                             : ImageTitles.themeLight)
            ) {
                Text("Светлая").tag(ThemeType.light)
                Text("Темная").tag(ThemeType.dark)
                Text("Системная").tag(ThemeType.system)
            }
            .pickerStyle(.menu)
        } label: {
            Image(systemName: ImageTitles.settingsMenu)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.colorBlack)
        }
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
        static let checkmark = "checkmark"
        static let themeLight = "circle.righthalf.filled"
        static let themeDark = "circle.lefthalf.filled"
    }
}

// MARK: - Preview - Data
#Preview("Data") {
    let router = NavigationRoute()
    let viewModel = ListsMainViewModel()
    ListsMainView(viewModel: viewModel)
        .environment(router)
}

// MARK: - Preview - Empty
#Preview("Empty") {
    let viewModel = ListsMainViewModel()
    ListsMainView(viewModel: viewModel)
}
