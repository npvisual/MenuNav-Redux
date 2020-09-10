//
//  ContentView.swift
//  Shared
//
//  Created by Nicolas Philippe on 9/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewSelection: Bool = false
    
    var body: some View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()        }
    }
}
