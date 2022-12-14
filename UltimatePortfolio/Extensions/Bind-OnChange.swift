//
//  Bind-OnChange.swift
//  UltimatePortfolio
//
//  Created by Ian Searcy-Gardner on 10/13/21.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}

