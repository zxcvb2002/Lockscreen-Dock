//
//  DockLiveActivity.swift
//  Dock
//
//  Created by 드즈 on 2022/12/16.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DockLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DockAttributes.self) { context in
            // Lock screen/banner UI goes here
            DockView(addedShortcuts: context.attributes.addedLinks)
                .activitySystemActionForegroundColor(Color.clear)
                .activityBackgroundTint(Color.clear)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.center) {
                    DockView(addedShortcuts: context.attributes.addedLinks)
                }   // Necessary! - As of now, we can disable dynamic islands, buy they will still be included with Live Activities!
            } compactLeading: {
            } compactTrailing: {
            } minimal: {
            }
            .keylineTint(Color.black)
        }
    }
    
    @ViewBuilder
    func DockView(addedShortcuts: [AppLink]) -> some View {
        HStack(spacing: 0) {
            ForEach(addedShortcuts) {link in
                // MARK: Live Activity Won't allow Button/Taps
                // It Instead allow Links to be used as Deep Links to navigate thorugh the App
                // In this Example we're navigating user to different app VIA Deep Link rather than within the App
                if let appURL = link.appURL {
                    Link(destination: appURL) {
                        Image(link.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(height: 85)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.ultraThinMaterial)
                .opacity(0)
        }
    }
}
