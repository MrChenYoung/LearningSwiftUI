//
//  EnvironmentAdaptor.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/29.
//

/**
 功能：主要是用来处理一些当前的系统设置的，比如说语言、时区、黑暗模式、CoreData的Context等
    在使用过程中一个很大的不同是，@Environment(_ keyPath:)需要指定一个类型为KeyPath的参数，而这个参数大多数情况下我们都是使用的EnvironmentValues中已经定义好的，比如managedObjectContext/locale等
 使用environmentObject进行环境变量传递有几点需要注意：
    1. 使用@Environment、@StateObject、@ObservedObject包装的类必须遵守ObservableObject协议，并且只能是类不能是结构体
    2. @Published也只能在class中使用，如果放在了struct中，会报错
    3. 使用@EnvironmentObject包装的变量是不需要初始化的，编译器会从环境变量中获取这个对象的值
    4. 在子视图中可以修改了环境变量的值，并且这个改变会在当前的视图层级中传递
 */
import SwiftUI

struct EnvironmentAdaptor: View {
    // 获取当前系统颜色模式
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        // 功能和注意事项说明
        let msg = """
        功能：主要是用来处理一些当前的系统设置的，比如说语言、时区、黑暗模式、CoreData的Context等
             在使用过程中一个很大的不同是，@Environment(_ keyPath:)需要指定一个类型为KeyPath的参数，而这个参数大多数情况下我们都是使用的EnvironmentValues中已经定义好的，比如managedObjectContext/locale等
             使用environmentObject进行环境变量传递有几点需要注意：
                1. 使用@Environment、@StateObject、@ObservedObject包装的类必须遵守ObservableObject协议，并且只能是类不能是结构体
                2. @Published也只能在class中使用，如果放在了struct中，会报错
                3. 使用@EnvironmentObject包装的变量是不需要初始化的，编译器会从环境变量中获取这个对象的值
                4. 在子视图中可以修改了环境变量的值，并且这个改变会在当前的视图层级中传递
"""
        // 根据当前颜色模式显示不同的文本
        let colorMsg = (colorScheme == .light ? "亮色模式" : "暗色模式")
        
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Text(msg)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                
                Text("示例:")
                    .font(.title)
                Text("获取当前系统颜色模式：\(colorMsg)")
                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
            }
        }
    }
}
