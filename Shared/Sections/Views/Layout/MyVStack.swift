//
//  MyVStack.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/4/1.
//

import SwiftUI

struct MyVStack: View {
    // 容器大小类型(默认自适应)
    @State var containerSizeType: ContainerSizeType = .fit
    
    var body: some View{
        VStack{
            // 设置面板views
            settingViews
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 160, height: 100)
                .foregroundColor(.green)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 260, height: 100)
                .foregroundColor(.red)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 80)
                .foregroundColor(.yellow)
        }
        .background(.blue)
    }
    
    // 设置面板views
    var settingViews: some View {
        VStack{
            Text("容器大小")
            Picker("容器大小", selection: $containerSizeType) {
                ForEach(ContainerSizeType.allCases){sizeType in
                    Text(sizeType.text).tag(sizeType)
                        .foregroundColor(.white)
                }
            }
//            .pickerStyle()
        }
    }
}

// 容器大小类型
enum ContainerSizeType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    // 自适应大小
    case fit
    // 自定义大小
    case custom
    // 全屏(保留安全区域)
    case fullWithSafeArea
    // 全屏(忽略安全区域)
    case fullNoneSafeArea
    
    var text: String {
        switch self {
        case .fit:
            return "自适应"
        case .custom:
            return "自定义"
        case .fullWithSafeArea:
            return "全屏(保留安全区域)"
        case .fullNoneSafeArea:
            return "全屏(忽略安全区域)"
        }
    }
}
