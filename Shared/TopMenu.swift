//
//  TopMenu.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI
import SwiftRex
import CombineRex

struct TopMenu<Label: View>: View {
    let label: () -> Label
    @ObservedObject var viewModel: ObservableViewModel<MenuEvent, MenuState>
    
    init(viewModel: ObservableViewModel<MenuEvent, MenuState>, @ViewBuilder label: @escaping () -> Label) {
        self.viewModel = viewModel
        self.label = label
    }

    var body: some View {
        Menu {
            ForEach(viewModel.state.menu) { content in
                // In case this is an item
                if case let .item(item) = content {
                    let newViewModel = ObservableViewModel.recursion(
                        store: viewModel,
                        newState: MenuState(item: item, menu: [])
                        )
                    TopItem(viewModel: newViewModel)
                }

                // In case this is a submenu
                if case let .submenu(item, contents) = content {
                    let newViewModel = ObservableViewModel.recursion(
                        store: viewModel,
                        newState: MenuState(item: item, menu: contents)
                        )
                    Submenu(
                        viewModel: newViewModel
                    )
                }
            }
        } label: { label() }
    }
}

struct Submenu: View {
    @ObservedObject var viewModel: ObservableViewModel<MenuEvent, MenuState>

    var body: some View {
        TopMenu(viewModel: viewModel) {
            HStack {
                Text(viewModel.state.item.text)
                if let imageName = viewModel.state.item.systemImage {
                    Image(systemName: imageName)
                }
            }
        }
    }
}

struct TopItem: View {
    @ObservedObject var viewModel: ObservableViewModel<MenuEvent, MenuState>

    func dispatch(_ action: MenuEvent) {
        // todo: call viewModel.dispatch
        print("Sending action \(action)")
    }

    init(viewModel: ObservableViewModel<MenuEvent, MenuState>) {
        self.viewModel = viewModel
    }

    var body: some View {
        Button(action: {
            viewModel.state.item.action.map { action in dispatch(action) }
        }) {
            viewModel.state.item.systemImage.map { systemImage in
                Image(systemName: systemImage)
                    .foregroundColor(.gray)
                    .imageScale(.large)
            }

            Text(viewModel.state.item.text)
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

struct TopMenu_Previews: PreviewProvider {
    
    static let mockState = AppState.mock
    static let mockStore = ObservableViewModel<AppAction, AppState>.mock(
        state: mockState,
        action: { action, _, state in
            state = Reducer.app.reduce(action, state)
        }
    )
    static let mockMenuModel = ObservableViewModel.menu(store: mockStore)

    
    static var previews: some View {
        TopMenu(viewModel: mockMenuModel) {
            Image(systemName: "line.horizontal.3")
        }
    }
}
