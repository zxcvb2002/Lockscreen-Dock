//
//  ContentView.swift
//  Lockscreen Dock
//
//  Created by 드즈 on 2022/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Lockscreen Dock")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
