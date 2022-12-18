//
//  DockAttributes.swift
//  Lockscreen Dock
//
//  Created by 드즈 on 2022/12/16.
//

import SwiftUI
import ActivityKit

struct DockAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
    // We don't need any Live update here, so ContentState will be empty
    var addedLinks: [AppLink]
}
