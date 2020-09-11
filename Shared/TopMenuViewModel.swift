//
//  TopMenuViewModel.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import Foundation
import CombineRex
import SwiftRex

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
        case let .submenu(item, _): return item.text
        }
    }

    case item(MenuItem)
    indirect case submenu(item: MenuItem, content: [MenuContent])
}

struct MenuState: Equatable {
    let item: MenuItem
    let menu: [MenuContent]

    static var empty: MenuState {
        .init(
            item: MenuItem(text: "", systemImage: nil, action: nil),
            menu: []
        )
        
    }
    
    static var `default`: MenuState {
        .init(
            item: MenuItem(text: "", systemImage: "line.horizontal.3", action: nil),
            menu: [
                .item(MenuItem(text: "Profile", systemImage: "person", action: .item1Tapped)),
                .item(MenuItem(text: "Family Members", systemImage: "person.3", action: .item2Tapped)),
                .item(MenuItem(text: "Events", systemImage: "calendar", action: .item3Tapped)),
                .submenu(item: MenuItem(text: "More", systemImage: "chevron.right", action: nil), content: [
                    .item(MenuItem(text: "Folders", systemImage: "folder.fill", action: nil)),
                    .item(MenuItem(text: "Deleted", systemImage: "trash.fill", action: nil))
                ])
            ]
        )
    }
}
