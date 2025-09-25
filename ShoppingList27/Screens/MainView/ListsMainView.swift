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
                label: Label(
                    Strings.installTema, systemImage: colorScheme == .dark
                    ? ImageTitles.themeDark
                    : ImageTitles.themeLight)
            ) {
                Text(Strings.brightTema).tag(ThemeType.light)
                Text(Strings.darkTema).tag(ThemeType.dark)
                Text(Strings.systemTema).tag(ThemeType.system)
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
            Image(systemName: ImageTitles.squareAndPencil)
        }
        .tint(.uniGrey)
    }
    
    func createDuplicateListButton(list: ShoppingList) -> some View {
        Button {
            duplicatingListButtonWasPressed(list: list)
        }
        label: {
            Image(systemName: ImageTitles.plusSquare)
        }
        .tint(.uniOrange)
    }
    
    func createDeleteListButton(list: ShoppingList) -> some View {
        Button {
            deleteListButtonWasPressed(list: list)
        }
        label: {
            Image(systemName: ImageTitles.trash)
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
        static let installTema = "Установить тему"
        static let brightTema = "Светлая"
        static let darkTema = "Темная"
        static let systemTema = "Системная"
    }
    
    enum ImageTitles {
        static let settingsMenu = "ellipsis.circle"
        static let checkmark = "checkmark"
        static let themeLight = "circle.righthalf.filled"
        static let themeDark = "circle.lefthalf.filled"
        static let trash = "trash"
        static let plusSquare = "plus.square.on.square"
        static let squareAndPencil = "square.and.pencil"
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
