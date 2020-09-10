//
//  TopMenuViewModel.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import Foundation

enum ViewEvent {
    case profileTapped
    case familyMembersTapped
    case eventsTapped
    case foldersTapped
    case deletedItemsTapped
}

struct MenuItem: Identifiable {
    var id: String { return text }
    let text: String
    let systemImage: String?
    let action: ViewEvent?
}

enum MenuContent: Identifiable {
    var id: String {
        switch self {
        case let .item(item): return item.id
        case let .submenu(text, _): return text
        }
    }

    case item(MenuItem)
    indirect case submenu(text: String, content: [MenuContent])
}

struct ViewState {
    let menu: [MenuContent]
    let content: String

    static var `default`: ViewState {
        .init(
            menu: [
                .item(MenuItem(text: "Profile", systemImage: "person", action: .profileTapped)),
                .item(MenuItem(text: "Family Members", systemImage: "person.3", action: .familyMembersTapped)),
                .item(MenuItem(text: "Events", systemImage: "calendar", action: .familyMembersTapped)),
                .submenu(text: "More", content: [
                    .item(MenuItem(text: "Folders", systemImage: "folder.fill", action: .foldersTapped)),
                    .item(MenuItem(text: "Deleted", systemImage: "trash.fill", action: .deletedItemsTapped))
                ])
            ],
            content: "Content")
    }
}
