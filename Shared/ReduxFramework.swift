//
//  ReduxApp.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import Foundation
import SwiftRex
import LoggerMiddleware
import CombineRex


// MARK: - ACTIONS
enum AppAction {
    case appLifecycle(AppLifecycleAction)
    case navigation(NavigationAction)
}

enum NavigationAction {
    case showView1
    case showView2
    case showView3
}

// MARK: - STATE
struct AppState: Equatable {
    var appLifecycle: AppLifecycle
    var viewSelection: ContentSelection = .content1
    
    var menuIconName: String = "line.horizontal.3"
    var menuContent1Title: String = "Content 1"
    var menuContent1IconName: String = "1.circle"
    var menuContent2Title: String = "Content 2"
    var menuContent2IconName: String = "2.circle"
    var menuContent3Title: String = "Content 3"
    var menuContent3IconName: String = "3.circle"

    enum ContentSelection {
        case content1
        case content2
        case content3
    }
    
    static var empty: AppState {
            .init(
                appLifecycle: .backgroundInactive
            )
    }
    
    static var mock: AppState {
        .init(
            appLifecycle: .backgroundInactive
        )
    }
}

// MARK: - REDUCERS
extension Reducer where ActionType == AppAction, StateType == AppState {
    static let app =
        Reducer<AppLifecycleAction, AppLifecycle>.lifecycle.lift(
            action: \AppAction.appLifecycle,
            state: \AppState.appLifecycle
        ) <> Reducer<NavigationAction, AppState>.menuNavigation.lift(
            action: \AppAction.navigation)
}

extension Reducer where ActionType == NavigationAction, StateType == AppState {
    static let menuNavigation = Reducer { action, state in
        var state = state
        switch action {
        case .showView1: state.viewSelection = .content1
        case .showView2: state.viewSelection = .content2
        case .showView3: state.viewSelection = .content3
        }
        return state
    }
}

// MARK: - MIDDLEWARE
let appMiddleware =
    IdentityMiddleware<AppAction, AppAction, AppState>().logger()
    <> AppLifecycleMiddleware().lift(
        inputActionMap: { _ in nil },
        outputActionMap: AppAction.appLifecycle,
        stateMap: { _ in }
    )

// MARK: - STORE
class Store: ReduxStoreBase<AppAction, AppState> {
    private init() {
        super.init(
            subject: .combine(initialValue: .mock),
            reducer: Reducer.app,
            middleware: appMiddleware
        )
    }
    
    static let instance = Store()
}


// MARK: - WORLD
struct World {
    let store: () -> AnyStoreType<AppAction, AppState>
}

extension World {
    static let origin = World(
        store: { Store.instance.eraseToAnyStoreType() }
    )
}

// MARK: - PROJECTIONS
extension ObservableViewModel where ViewAction == ContentView.ViewEvent, ViewState == ContentView.ViewState {
    static func content<S: StoreType>(store: S) -> ObservableViewModel
    where S.ActionType == AppAction, S.StateType == AppState {
        return store
            .projection(action: Self.transform, state: Self.transform)
            .asObservableViewModel(initialState: .empty)
    }
    
    private static func transform(_ viewAction: ContentView.ViewEvent) -> AppAction? {
        switch viewAction {
        }
    }
    
    private static func transform(from state: AppState) -> ContentView.ViewState {
        var selection: ContentView.ViewSelection
        switch state.viewSelection {
        case .content1: selection = .view1
        case .content2: selection = .view2
        case .content3: selection = .view3
        }
        
        return ContentView.ViewState(
            selectedView: selection
        )
    }
}

extension ObservableViewModel where ViewAction == MenuEvent, ViewState == MenuState {
    static func menu<S: StoreType>(store: S) -> ObservableViewModel
    where S.ActionType == AppAction, S.StateType == AppState {
        return store
            .projection(action: Self.transform, state: Self.transform)
            .asObservableViewModel(initialState: .empty)
    }
    
    private static func transform(_ viewAction: MenuEvent) -> AppAction? {
        switch viewAction {
        case .item1Tapped: return .navigation(.showView1)
        case .item2Tapped: return .navigation(.showView2)
        case .item3Tapped: return .navigation(.showView3)
        }
    }
    
    private static func transform(from state: AppState) -> MenuState {
        MenuState(
            menu: [
                .item(MenuItem(text: state.menuContent1Title, systemImage: state.menuContent1IconName, action: nil)),
                .item(MenuItem(text: state.menuContent2Title, systemImage: state.menuContent2IconName, action: nil)),
                .item(MenuItem(text: state.menuContent3Title, systemImage: state.menuContent3IconName, action: nil))
            ],
            content: "Content")
    }
}
