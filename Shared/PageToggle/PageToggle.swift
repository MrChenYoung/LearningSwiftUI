//
//  MySheet.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/30.
//

import SwiftUI

struct PageToggle: View{
    // 页面切换方式
    var pageToggleType: PageToggleType
    
    // 返回首页标识
    @State var isPushedPage1 = false
    
    var body: some View{
        // 根据页面跳转方式不同调用不同的跳转
        switch self.pageToggleType{
        case .sheet:
            // 模态跳转
            viewForSheet
        case .fullScreenCover:
            // 全屏模态跳转
            viewForFullScreenCover
        case .navigationLink:
            // 导航方式跳转
            viewForNavigationLink
        }
    }
    
    
    // 模态方式页面样式
    var viewForSheet: some View {
        VStack{
            Text("第一页")
                .font(.headline)
                .padding(.vertical, 5)
            Button("下一页") {
                // 通过修改该bool值，控制页面弹出
                isPushedPage1 = true
            }
            .padding(5)
            .foregroundColor(.white)
            .background(.blue)
            .sheet(isPresented: $isPushedPage1) {
                SecondPage(pageToggleType: self.pageToggleType, isPushedPage1: $isPushedPage1)
            }
        }
    }
    
    // 全屏模态方式页面样式
    var viewForFullScreenCover: some View {
        VStack{
            Text("第一页")
                .font(.headline)
                .padding(.vertical, 5)
            
            Button("下一页") {
                // 通过修改该bool值，控制页面弹出
                isPushedPage1 = true
            }
            .padding(5)
            .foregroundColor(.white)
            .background(.blue)
            .fullScreenCover(isPresented: $isPushedPage1) {
                SecondPage(pageToggleType: self.pageToggleType, isPushedPage1: $isPushedPage1)
            }
        }
    }
    
    // 导航方式页面样式
    var viewForNavigationLink: some View{
        VStack{
            Text("第一页")
                .font(.headline)
                .padding(.vertical, 5)
            
            NavigationLink(destination: SecondPage(pageToggleType: pageToggleType, isPushedPage1: $isPushedPage1), isActive: $isPushedPage1) {
                Text("下一页")
                    .padding(5)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background(.blue)
            }
        }
    }
}


