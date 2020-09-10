//
//  ContentViewModel.swift
//  MenuNav-Redux
//
//  Created by Nicolas Philippe on 9/10/20.
//

import Foundation
import CombineRex

extension ContentView {
    
    enum ViewEvent {
        
    }
    
    struct ViewState: Equatable {
        var selectedView: ViewSelection
        
        static let empty = ViewState(
            selectedView: .view1
        )
    }
    
    enum ViewSelection {
        case view1
        case view2
        case view3
    }
}
