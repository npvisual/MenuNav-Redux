//
//  TopMenuViewModel.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import Foundation

enum MenuEvent {
    case item1Tapped
    case item2Tapped
    case item3Tapped
}

struct MenuItem: Identifiable, Equatable {
    var id: String { return text }
    let text: String
    let systemImage: String?
    let action: MenuEvent?
}

enum MenuContent: Identifiable, Equatable {
    var id: String {
        switch self {
        case let .item(item): return item.id
        case let .submenu(text, _): return text
        }
    }

    case item(MenuItem)
    indirect case submenu(text: String, content: [MenuContent])
}

struct MenuState: Equatable {
    let menu: [MenuContent]
    let content: String

    static var empty: MenuState {
        .init(
            menu: [],
            content: ""
        )
        
    }
    
    static var `default`: MenuState {
        .init(
            menu: [
                .item(MenuItem(text: "Profile", systemImage: "person", action: .item1Tapped)),
                .item(MenuItem(text: "Family Members", systemImage: "person.3", action: .item2Tapped)),
                .item(MenuItem(text: "Events", systemImage: "calendar", action: .item3Tapped)),
                .submenu(text: "More", content: [
                    .item(MenuItem(text: "Folders", systemImage: "folder.fill", action: nil)),
                    .item(MenuItem(text: "Deleted", systemImage: "trash.fill", action: nil))
                ])
            ],
            content: "Content")
    }
}
