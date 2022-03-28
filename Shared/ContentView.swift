//
//  ContentView.swift
//  Shared
//
//  Created by MrChen on 2022/3/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List(viewsList, children: \.children){item in
                if item.children == nil {
                    NavigationLink(destination: Text("Hello")){
                        Text("\(item.description)")
                    }
                }else {
                    Text("\(item.description)")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("SwiftUI")
        }
    }
    
    // 树状是否展开状态
    @State var isExpanded: Bool = true
    
    // 数据
   private let viewsList: [ListItem] = [
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
                ListItem(title: "TextView")
            ]
        )
    ]
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
