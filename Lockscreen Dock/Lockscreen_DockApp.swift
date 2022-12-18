//
//  Lockscreen_DockApp.swift
//  Lockscreen Dock
//
//  Created by 드즈 on 2022/12/16.
//

import SwiftUI

@main
struct Lockscreen_DockApp: App {
    @Environment(\.openURL) var OpenURL     // SwiftUI Native's openURL() method
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // Simply Pass the URL (print(url))
                    OpenURL(url)
                }
        }
    }
}
