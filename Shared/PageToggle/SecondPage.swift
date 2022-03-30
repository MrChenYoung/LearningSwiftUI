//
//  SecondPage.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/30.
//

import SwiftUI

struct SecondPage: View{
    // 页面切换方式
    var pageToggleType: PageToggleType
    
    // 模态控制环境变量
    @Environment(\.presentationMode) var presentMode
    
    // 第二页是否显示控制标识
    @State var isPushedPage2 = false
    
    // 第一页是否显示控制标识
    @Binding var isPushedPage1: Bool
    
    var body: some View{
        VStack{
            Text("第二页")
                .font(.headline)
            
            // 根据跳转方式不同 调用跳转/返回方法
            switch self.pageToggleType{
            case .sheet:
                viewForSheet
            case .fullScreenCover:
                viewForFullScreenCover
            case .navigationLink:
                viewForNavigationLink
            }
        }
        
        
    }
    
    // 模态方式页面样式
    var viewForSheet: some View{
        VStack{
            HStack{
                // 返回上一页
                MyButton(title: "返回方式1") {
                    self.presentMode.wrappedValue.dismiss()
                }
                MyButton(title: "返回方式2") {
                    self.isPushedPage1 = false
                }
            }
            
            // 下一页
            Button("下一页") {
                self.isPushedPage2 = true
            }
            .padding(5)
            .foregroundColor(.white)
            .background(.blue)
            .sheet(isPresented: $isPushedPage2) {
                ThirdPage(pageToggleType: pageToggleType, isPushedPage1: $isPushedPage1, isPushedPage2: $isPushedPage2)
            }
        }
    }
    
    // 全屏模态方式页面样式
    var viewForFullScreenCover: some View {
        VStack{
            HStack{
                MyButton(title: "返回方式1") {
                    self.presentMode.wrappedValue.dismiss()
                }
                MyButton(title: "返回方式2"){
                    self.isPushedPage1 = false
                }
                
                // 下一页
                Button("下一页") {
                    self.isPushedPage2 = true
                }
                .padding(5)
                .foregroundColor(.white)
                .background(.blue)
                .fullScreenCover(isPresented: $isPushedPage2) {
                    ThirdPage(pageToggleType: pageToggleType, isPushedPage1: $isPushedPage1, isPushedPage2: $isPushedPage2)
                }
            }
        }
    }
    
    // 导航方式页面样式
    var viewForNavigationLink: some View{
        VStack{
            HStack{
                MyButton(title: "返回方式1"){
                    self.presentMode.wrappedValue.dismiss()
                }
                MyButton(title: "返回方式2"){
                    self.isPushedPage1 = false
                }
            }
            
            NavigationLink(destination: ThirdPage(pageToggleType: pageToggleType, isPushedPage1: $isPushedPage1, isPushedPage2: $isPushedPage2), isActive:$isPushedPage2, label: {
                // 下一页
                Button("下一页") {
                    self.isPushedPage2 = true
                }
                .padding(5)
                .foregroundColor(.white)
                .background(.blue)
            })
        }
    }
}
