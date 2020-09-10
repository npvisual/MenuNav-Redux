//
//  TopMenu.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI

struct TopMenu<Label: View>: View {
    let label: () -> Label
    let contents: [MenuContent]

    init(contents: [MenuContent], @ViewBuilder label: @escaping () -> Label) {
        self.contents = contents
        self.label = label
    }

    var body: some View {
        Menu {
            ForEach(contents) { content in
                // In case this is an item
                if case let .item(item) = content {
                    TopItem(item: item)
                }

                // In case this is a submenu
                if case let .submenu(text, contents) = content {
                    Submenu(text: text, contents: contents)
                }
            }
        } label: { label() }
    }
}

struct Submenu: View {
    let text: String
    let contents: [MenuContent]

    var body: some View {
        TopMenu(contents: contents) {
            HStack {
                Text(text)
                Image(systemName: "chevron.right")
            }
        }
    }
}

struct TopItem: View {
    let item: MenuItem

    func dispatch(_ action: MenuEvent) {
        // todo: call viewModel.dispatch
        print("Sending action \(action)")
    }

    init(item: MenuItem) {
        self.item = item
    }

    var body: some View {
        Button(action: {
            item.action.map { action in dispatch(action) }
        }) {
            item.systemImage.map { systemImage in
                Image(systemName: systemImage)
                    .foregroundColor(.gray)
                    .imageScale(.large)
            }

            Text(item.text)
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

struct TopMenu_Previews: PreviewProvider {
    
    static let menu = MenuState.default.menu
    
    static var previews: some View {
        TopMenu(contents: menu) {
            Image(systemName: "line.horizontal.3")
        }
    }
}
