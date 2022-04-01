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

  var body: some View {
    NavigationLink {
      ItemLinkView(itemTitle: item.title)
    } label: {
      Text("\(item.description)")
    }
  }

  // 点击每一行跳转到指定的View
  struct ItemLinkView: View {
    // 一行的标题
    let itemTitle: String

    var body: some View {
      switch itemTitle {
      case "Text":
        MyText()
      case "LazyVGrid":
        MyLazyVGrid()
      case "LazyHGrid":
        MyLazyHGrid()
      case "@main":
        MainAdaptor()
      case "@UIApplicationDelegateAdaptor":
        ApplicationDelegateAdaptor()
      case "@Environment":
        EnvironmentAdaptor()
      case "sheet":
        PageToggle(pageToggleType: .sheet)
      case "fullScreenCover":
        PageToggle(pageToggleType: .fullScreenCover)
      case "NavigationLink":
        PageToggle(pageToggleType: .navigationLink)
      default:
        Text("SwiftUI")
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
      ListItem(
        title: "栅栏",
        children: [
          ListItem(title: "LazyHGrid"),
          ListItem(title: "LazyVGrid"),
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
      ListItem(title: "@Environment"),
    ]
  ),
  ListItem(
    title: "页面跳转",
    children: [
      ListItem(
        title: "模态方式",
        children: [
          ListItem(title: "sheet"),
          ListItem(title: "fullScreenCover"),
        ]
      ),
      ListItem(
        title: "导航跳转",
        children: [
          ListItem(title: "NavigationLink")
        ]
      ),
    ]
  ),
]

/// 页面跳转方式
///  - 模态
///  - 全屏模态
///  - 导航
enum PageToggleType {
  case sheet
  case fullScreenCover
  case navigationLink
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
