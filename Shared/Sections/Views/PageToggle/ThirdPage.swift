//
//  ThirdPage.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/30.
//

import SwiftUI

struct ThirdPage: View{
    // 页面切换方式
    var pageToggleType: PageToggleType
    
    // 模态环境mode
    @Environment(\.presentationMode) var presentModel
    
    // 第一页是否显示控制标识
    @Binding var isPushedPage1: Bool
    
    // 第二页是否显示控制标识
    @Binding var isPushedPage2: Bool
    
    var body: some View{
        // 根据页面跳转方式调用不同导入返回方式
        switch pageToggleType {
        case .sheet:
            viewForSheet
        case .fullScreenCover:
            viewForSheet
        case .navigationLink:
            viewForNavgationLink
        }
    }
    
    // 模态方式页面布局/全屏模态显示
    var viewForSheet: some View {
        VStack{
            Text("第三页")
                .font(.headline)
            
            HStack{
                MyButton(title: "返回方式1") {
                    self.presentModel.wrappedValue.dismiss()
                }
                MyButton(title: "返回方式2") {
                    self.isPushedPage2 = false
                }
                MyButton(title: "返回首页") {
                    self.isPushedPage1 = false
                }
            }
        }
    }
    
    // 导航方式页面布局
    var viewForNavgationLink: some View{
        VStack{
            Text("第三页")
                .font(.headline)
            
            HStack{
                MyButton(title: "返回方式1"){
                    self.presentModel.wrappedValue.dismiss()
                }
                MyButton(title: "返回方式2"){
                    self.isPushedPage2 = false
                }
                MyButton(title: "返回首页"){
                    self.isPushedPage1 = false
                }
            }
        }
    }
}

// 按钮样式封装
struct MyButton: View {
    // 标题
    var title: String = ""
    
    // 背景色
    var bgColor: Color = .blue
    
    // 点击事件
    var backAction: ()->Void
    
    var body: some View{
        Button(title, action: backAction)
        .padding(5)
        .font(.headline)
        .foregroundColor(.white)
        .background(bgColor)
    }
}
