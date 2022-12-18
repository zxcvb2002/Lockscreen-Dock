//
//  Home.swift
//  Lockscreen Dock
//
//  Created by 드즈 on 2022/12/16.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct Home: View {
    // MARK: Added Shortcuts Data
    @State var addedShortcuts: [AppLink] = []
    @State var availableAppLinks: [AppLink]  = []
    var body: some View {
        List {
            Section {
                // MARK: Displaying Preview
                // Which will be almost same as the Lockscreen Dock Live Activity
                HStack(spacing: 0) {
                    ForEach(addedShortcuts) {link in
                        Image(link.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    addedShortcuts.removeAll(where: {$0 == link})
                                }
                            }
                    }
                }
                .frame(height: 85)
            } header: {
                Text("Preview")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(availableAppLinks.filter({!addedShortcuts.contains($0)})){link in
                            VStack(spacing: 8) {
                                Image(link.name)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                
                                Text(link.name)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    addedShortcuts.append(link)
                                }
                            }
                        }
                    }
                    .frame(height: 100)
                    .padding(.horizontal,10)
                }
                // MARK: We're Only Allowing max of 4 Apps on the Dock
                // So Disabling it when the count exceeds 4
                .disabled(addedShortcuts.count >= 4)
                .opacity(addedShortcuts.count >= 4 ? 0.6 : 1)
            } header: {
                Text("Tap to add shortcut")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Button(action: addDocktoLockScreen){
                HStack {
                    Text("Add Lockscreen Dock")
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Image(systemName: "dock.rectangle")
                }
            }
            // MARK: Minimum 2 Apps Needed to add Dock to Lockscreen
            .disabled(addedShortcuts.count < 2)
            .opacity(addedShortcuts.count < 2 ? 0.6 : 1)
        }
        .onAppear {
            // MARK: Checking Which App's are Available in the User's iPhone
            // And Updating AppLink Model base on that so that unavailable apps wasn't appear on the Home Screen
            // Checking Deep Links - Some apps will no be able on all phones, so it is necessary to filter available apps and save them as a seperate array.
            for link in appLinks {
                if let url = URL(string: link.deepLink) {
                    if UIApplication.shared.canOpenURL(url) {
                        // Available On the iPhone
                        var updatedLink = link
                        updatedLink.appURL = url
                        availableAppLinks.append(updatedLink)
                    }
                    // Else App Not Found on the iPhone
                }
                // Else Invalid URL
            }
        }
    }
    
    func addDocktoLockScreen() {
        // MARK: Removing All Existing Activities Which Was added before
        removeExistingDock()    // Little Update : removeExistingDock() should not be added to the addDocktoLockScreen() method. Instead, add the addDockScreen() method after the for loop in the removeExistingDock() method and replace the button action with removeExistingDock.
        // MARK: Live Activity Code Goes Here
        
        // Step 1: Creating Live Activity Attribute
        let activityAttribute = DockAttributes(name: "LockScreen Dock", addedLinks: addedShortcuts)
        // Step 2: Creating Content State for the Live Activity Attribute
        let initialContentState = DockAttributes.ContentState()
        // Step 3: Adding Live activity to the Lock Screen
        do {
            // Step 4: Creating Activity
            let activity = try Activity<DockAttributes>.request(attributes: activityAttribute, contentState: initialContentState)
            // warning(error) : 'request(attributes:contentState:pushType:)' was deprecated in iOS 16.2: Use request(attributes:content:pushType:) instead
            print("Activity Added \(activity.id)")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func removeExistingDock() {
        Task {
            for activity in Activity<DockAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
                // warning(error) : 'end(using:dismissalPolicy:)' was deprecated in iOS 16.2: Use end(content:dismissalPolicy:) instead
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
