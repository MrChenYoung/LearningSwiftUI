//
//  LearningSwiftUIApp.swift
//  Shared
//
//  Created by MrChen on 2022/3/28.
//

import SwiftUI

@main
struct LearningSwiftUIApp: App {
  // 注入appdelegate
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appdelegate
    
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
