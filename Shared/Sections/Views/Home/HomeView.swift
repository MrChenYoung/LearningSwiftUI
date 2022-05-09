//
//  ContentView.swift
//  Shared
//
//  Created by MrChen on 2022/3/28.
//

import Foundation
import SwiftUI

struct HomeView: View {
    // viewModel
    var homeVM: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List(homeVM.homeData, children: \.children) { item in
            if item.children == nil {
              // 要跳转的页面
              Cell(item: item)
            }
            else {
              Text("\(item.title)")
            }
          }
          .listStyle(.grouped)
          .navigationTitle("SwiftUI")
        }
    }
}

// 点击跳转的行
struct Cell: View {
    var item: HomeListModel
    
    var body: some View {
        NavigationLink {
            ItemLinkView(itemTitle: item.title)
        } label: {
            VStack(alignment: .leading, spacing: 0){
                Text("\(item.title)")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                if item.subTitle != nil {
                    Text("\(item.subTitle!)")
                        .padding(.vertical, 6)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                }
            }
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
            case "垂直布局":
                MyVStack()
            case "纵向栏格":
                MyLazyVGrid()
            case "横向栏格":
                MyLazyHGrid()
            case "APP入口":
                MainAdaptor()
            case "APP代理":
                ApplicationDelegateAdaptor()
            case "环境变量":
                EnvironmentAdaptor()
            case "简单模态":
                PageToggle(pageToggleType: .sheet)
            case "全屏模态":
                PageToggle(pageToggleType: .fullScreenCover)
            case "导航跳转":
                PageToggle(pageToggleType: .navigationLink)
            default:
                Text("SwiftUI")
            }
        }
    }
}

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
        HomeView()
    }
}
