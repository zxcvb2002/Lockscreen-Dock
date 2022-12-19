//
//  AppLink.swift
//  Lockscreen Dock
//
//  Created by 드즈 on 2022/12/16.
//

import SwiftUI

// MARK: AppLink Model and Sample Deep Links to Some Apps
struct AppLink: Identifiable, Equatable, Codable, Hashable {
    var id: UUID = .init()
    var name: String    // App Name/Asset Name
    var deepLink: String    // App Deep Link String
    var status: Bool = false    // Deep Link Available Status
    var appURL: URL?    // Verified Deep Link URL
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case deepLink
        case status
        case appURL
    }
}

// MARK: Sample Links
var appLinks: [AppLink] = [
    .init(name: "Google Maps", deepLink: "comgooglemaps://"),
    .init(name: "Instagram", deepLink: "instagram://"),
    .init(name: "Maps", deepLink: "maps://"),
    .init(name: "Photos", deepLink: "photos-redirect://"),
    .init(name: "Shortcuts", deepLink: "shortcuts://"),
    .init(name: "Stocks", deepLink: "stocks://"),
    .init(name: "Youtube", deepLink: "youtube:?//"),
]
// Deep Link String - You can easily obtain an app's deep link string by searching Google for its url schemes. (Google's deep link, for example, will be "https://www.google.com"))
