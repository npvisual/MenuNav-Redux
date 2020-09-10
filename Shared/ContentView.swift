//
//  ContentView.swift
//  Shared
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewSelection: Bool
    @State var viewState: ViewState
    
    var body: some View {
        NavigationView {
            VStack {
                Button(
                    action: { self.viewSelection.toggle() },
                    label: { Text("Change view") }
                )
                if viewSelection {
                    Text("Hello World 1 !")
                } else {
                    Text("Hello World 2 !")
                }
            }
            .navigationBarItems(leading:             TopMenu(contents: viewState.menu) {
                Image(systemName: "line.horizontal.3")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(
                viewSelection: true,
                viewState: ViewState.default
            )
        }
    }
}
