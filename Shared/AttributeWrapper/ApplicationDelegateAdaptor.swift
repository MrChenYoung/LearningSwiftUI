//
//  ApplicationDelegateAdaptor.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/29.
//

/**
 功能：App中用于提供UIKit委托的属性包装器
    默认的swift2.0项目已经没有了传统的UIAppDelegate，如果想要使用旧的UIApplicationDelegate生命周期，就必须使用该属性包装器
 用法：
  1. 创建Appdelegate类
  2. 在入口类文件(遵循App协议的结构体)中注入AppDelegate

  3.可以像以前一样使用Appdelegate类里面应用程序的声明周期
 */

import SwiftUI

struct ApplicationDelegateAdaptor: View {
  private let message = """
        功能：App中用于提供UIKit委托的属性包装器
           默认的swift2.0项目已经没有了传统的UIAppDelegate，如果想要使用旧的UIApplicationDelegate生命周期，就必须使用该属性包装器
        用法：
         1. 创建Appdelegate类
         2. 在入口类文件(遵循App协议的结构体)中注入AppDelegate
                
         3.可以像以前一样使用Appdelegate类里面应用程序的声明周期
    """
  var body: some View {
      VStack{
          Text(message)
            .font(.headline)
            .foregroundColor(.blue)
            .padding()
          
          Spacer()
      }
      .frame(width: ScreenW, height: ScreenH-topSafeHeight-bottomSafeHeight)
  }
}
