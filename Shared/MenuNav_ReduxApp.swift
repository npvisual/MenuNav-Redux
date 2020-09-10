//
//  MenuNav_ReduxApp.swift
//  Shared
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI

@main
struct MenuNav_ReduxApp: App {
    
    let viewState: ViewState = ViewState.default
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewSelection: true,
                viewState: viewState
            )
        }
    }
}
