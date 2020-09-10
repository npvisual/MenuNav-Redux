//
//  ActionPrism.swift
//  TurboPool
//
//  Created by Nicolas Philippe on 8/20/20.
//  Copyright © 2020 NPVTech. All rights reserved.
//
//  See : https://github.com/SwiftRex/SwiftRex/blob/develop/docs/markdown/ActionEnumProperties.md

import Foundation

// TODO: Use code-generation

// MARK: - PRISM

extension AppAction {
    public var appLifecycle: AppLifecycleAction? {
        get {
            guard case let .appLifecycle(value) = self else { return nil }
            return value
        }
        set {
            guard case .appLifecycle = self, let newValue = newValue else { return }
            self = .appLifecycle(newValue)
        }
    }

    public var isAppLifecycle: Bool {
        self.appLifecycle != nil
    }
}

extension AppAction {
    public var navigation: NavigationAction? {
        get {
            guard case let .navigation(value) = self else { return nil }
            return value
        }
        set {
            guard case .navigation = self, let newValue = newValue else { return }
            self = .navigation(newValue)
        }
    }
    
    public var isNavigation: Bool {
    self.navigation != nil
    }
}

