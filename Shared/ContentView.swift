//
//  ContentView.swift
//  Shared
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI
import SwiftRex
import CombineRex

struct ContentView: View {
    
    @ObservedObject var viewModel: ObservableViewModel<ViewEvent, ViewState>
    @ObservedObject var menuModel: ObservableViewModel<MenuEvent, MenuState>
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state.selectedView {
                case .view1: ContentOne()
                case .view2: ContentTwo()
                case .view3: ContentThree()
                }
            }
            .navigationBarItems(
                leading: TopMenu(viewModel: menuModel) {
                    Image(systemName: viewModel.state.menuTopIconName)
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let mockState = AppState.mock
    static let mockStore = ObservableViewModel<AppAction, AppState>.mock(
        state: mockState,
        action: { action, _, state in
            state = Reducer.app.reduce(action, state)
        }
    )
    static let mockViewModel = ObservableViewModel.content(store: mockStore)
    static let mockMenuModel = ObservableViewModel.menu(store: mockStore)
    
    static var previews: some View {
        Group {
            ContentView(
                viewModel: mockViewModel,
                menuModel: mockMenuModel
            )
        }
    }
}
