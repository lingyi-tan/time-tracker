//
//  time_trackerApp.swift
//  time-tracker
//
//  Created by lingyi on 2023-12-02.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        window = NSApplication.shared.windows.first
        window?.toggleFullScreen(nil)
    }
}

@main
struct time_trackerApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
