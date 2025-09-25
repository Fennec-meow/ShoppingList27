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
    
    // MARK: Private Properties
    
    @Query private var lists: [ShoppingList]
    
    @ObservedObject private var viewModel: ListsMainViewModel
    @State private var isCreatingNewList: Bool = false
    @AppStorage("ThemeType") private var selectedThemeType: ThemeType = .system
    @Environment(\.colorScheme) private var colorScheme
    
    @Environment(NavigationRoute.self) private var router
    @Environment(\.modelContext) private var context
    
    // MARK: Body
    
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
    
    // MARK: Initializer
    
    init(viewModel: ListsMainViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Subviews

private extension ListsMainView {
    
    @ViewBuilder
    var content: some View {
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
    
    var listsScrollView: some View {
        List {
            ForEach(lists) { list in
                ListItemView(item: list)
                    .swipeActions(allowsFullSwipe: false) {
                        createDeleteListButton(list: list)
                        createDuplicateListButton(list: list)
                        createEditListButton(list: list)
                    }
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
    
    var createListButton: some View {
        BaseButton(title: Strings.createList,
                   action: {
            print("CreatingNewList")
            isCreatingNewList = true
            router.push(.listEditor(list: nil, registeredTitles: []))
        })
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    var titleView: some View {
        Text(Strings.title)
            .font(.Title1.semiBold)
            .foregroundStyle(Color.grey80)
    }
    
    var settingsMenu: some View {
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
}

// MARK: - Private Methods

private extension ListsMainView {
    func editListButtonWasPressed(list: ShoppingList) {
        viewModel.editList(list)
        router.push(.listEditor(list: list, registeredTitles: []))
    }
    
    func duplicatingListButtonWasPressed(list: ShoppingList) {
        let duplicatedList = viewModel.duplicatingList(list, context: context)
        router.push(.listEditor(list: duplicatedList, registeredTitles: []))
    }
    
    func deleteListButtonWasPressed(list: ShoppingList) {
        viewModel.deleteList(list, context: context)
    }
    
    func createEditListButton(list: ShoppingList) -> some View {
        Button {
            editListButtonWasPressed(list: list)
        }
        label: {
            Image(systemName: "square.and.pencil")
        }
        .tint(.uniGrey)
    }
    
    func createDuplicateListButton(list: ShoppingList) -> some View {
        Button {
            duplicatingListButtonWasPressed(list: list)
        }
        label: {
            Image(systemName: "plus.square.on.square")
        }
        .tint(.uniOrange)
    }
    
    func createDeleteListButton(list: ShoppingList) -> some View {
        Button {
            deleteListButtonWasPressed(list: list)
        }
        label: {
            Image(systemName: "trash")
                .environment(\.symbolVariants, .none)
        }
        .tint(.uniRed)
    }
}

// MARK: - Constants

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
