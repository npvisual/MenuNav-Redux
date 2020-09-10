//
//  MenuNav_ReduxApp.swift
//  Shared
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI
import CombineRex

@main
struct MenuNav_ReduxApp: App {
    
    @StateObject var store = World
        .origin
        .store()
        .asObservableViewModel(initialState: .empty)
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ObservableViewModel.content(store: store),
                menuModel: ObservableViewModel.menu(store: store)
            )
        }
    }
}
