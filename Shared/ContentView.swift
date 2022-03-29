//
//  ContentView.swift
//  Shared
//
//  Created by MrChen on 2022/3/28.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List(viewsList, children: \.children) { item in
        if item.children == nil {
            // 要跳转的页面
            Cell(item: item)
        }
        else {
          Text("\(item.description)")
        }
      }
      .listStyle(.grouped)
      .navigationTitle("SwiftUI")
    }
  }
}

// 点击跳转的行
struct Cell: View {
    var item: ListItem
    
    var body: some View{
        switch item.description{
        case "@main":
            NavigationLink(destination: MainAdaptor()) {
            Text("\(item.description)")
          }
        case "@UIApplicationDelegateAdaptor":
            NavigationLink(destination: ApplicationDelegateAdaptor()) {
            Text("\(item.description)")
          }
        case "@Environment":
            NavigationLink(destination: EnvironmentAdaptor()) {
            Text("\(item.description)")
          }
        default:
            NavigationLink(destination: Text("SwiftUI")) {
            Text("\(item.description)")
          }
        }
    }
}

struct ListItem: Hashable, Identifiable, CustomStringConvertible {
  var id: Self { self }
  // 标题
  var title: String
  // 子节点
  var children: [ListItem]? = nil

  var description: String {
    return "\(title)"
  }
}

// 数据
private let viewsList: [ListItem] = [
  ListItem(
    title: "Views",
    children: [
      ListItem(
        title: "文本显示",
        children: [
          ListItem(title: "Text")
        ]
      ),
      ListItem(
        title: "输入框",
        children: [
          ListItem(title: "TextField"),
          ListItem(title: "SecureField"),
          ListItem(title: "TextView"),
        ]
      ),
    ]
  ),
  ListItem(
    title: "布局",
    children: [
      ListItem(title: "frame"),
      ListItem(title: "LayoutGuide"),
    ]
  ),
  ListItem(
    title: "属性包装器",
    children: [
      ListItem(title: "@main"),
      ListItem(title: "@UIApplicationDelegateAdaptor"),
      ListItem(title: "@Environment")
    ]
  ),
]

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
