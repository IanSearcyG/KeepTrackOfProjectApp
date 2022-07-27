//
//  SelectSomethingView.swift
//  UltimatePortfolio
//
//  Created by Ian Searcy-Gardner on 12/5/21.
//

import SwiftUI

struct SelectSomethingView: View {
    var body: some View {
        Text("Please select something from the menu to begin.")
            .italic()
            .foregroundColor(.secondary)
    }
}

struct SelectSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSomethingView()
    }
}
