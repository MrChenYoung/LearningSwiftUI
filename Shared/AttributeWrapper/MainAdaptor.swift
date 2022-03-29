//
//  MainAdaptor.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/29.
//
/**
 功能：声明程序入口
  SwiftUI 2 在 WWDC 2020上的发布，苹果引入了一个新的应用程序生命周期(App)。替代了 AppDelegate。
 */

import SwiftUI

struct MainAdaptor: View {
  private let msg = """
    功能：声明程序入口
         SwiftUI 2 在 WWDC 2020上的发布，苹果引入了一个新的应用程序生命周期(App)。替代了 AppDelegate。
    """

  var body: some View {
      VStack{
          Text(msg)
            .font(.headline)
            .foregroundColor(.blue)
          
          Spacer()
      }
      .frame(width: ScreenW, height: ScreenH-topSafeHeight-bottomSafeHeight)
  }
}
