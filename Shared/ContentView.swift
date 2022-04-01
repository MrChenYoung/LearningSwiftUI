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
      case "纵向栏格(LazyVGrid)":
        MyLazyVGrid()
      case "横向栏格(LazyHGrid)":
        MyLazyHGrid()
      case "APP入口(@main)":
        MainAdaptor()
      case "APP代理(@UIApplicationDelegateAdaptor)":
        ApplicationDelegateAdaptor()
      case "环境变量(@Environment)":
        EnvironmentAdaptor()
      case "简单模态(sheet)":
        PageToggle(pageToggleType: .sheet)
      case "全屏模态(fullScreenCover)":
        PageToggle(pageToggleType: .fullScreenCover)
      case "导航跳转(NavigationLink)":
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
      )
    ]
  ),
  ListItem(
    title: "布局",
    children: [
        ListItem(title: "水平布局(HStack)"),
        ListItem(title: "垂直布局(VStack)"),
        ListItem(title: "Z轴纵向布局(ZStack)"),
        ListItem(title: "横向栏格(LazyHGrid)"),
        ListItem(title: "纵向栏格(LazyVGrid)"),
        ListItem(title: "LayoutGuide"),
    ]
  ),
  ListItem(
    title: "属性包装器",
    children: [
      ListItem(title: "APP入口(@main)"),
      ListItem(title: "APP代理(@UIApplicationDelegateAdaptor)"),
      ListItem(title: "环境变量(@Environment)"),
    ]
  ),
  ListItem(
    title: "修饰器(modifier)",
    children: [
        ListItem(title: "frame")
    ]
  ),
  ListItem(
    title: "页面跳转",
    children: [
      ListItem(
        title: "模态方式",
        children: [
          ListItem(title: "简单模态(sheet)"),
          ListItem(title: "全屏模态(fullScreenCover)"),
        ]
      ),
      ListItem(
        title: "导航跳转",
        children: [
          ListItem(title: "导航跳转(NavigationLink)")
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
