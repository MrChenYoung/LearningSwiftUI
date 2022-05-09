//
//  MyLazyHGrid.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/4/1.
//

import SwiftUI

struct MyLazyHGrid: View {
  // 格子的个数
  @State private var itemCount = 10
  // 行数
  @State private var rowCount = 2

  // 两个格子垂直方向间距
  @State private var itemSpaceVertical: Float = 20.0
  // 两个格子水平方向间距
  @State private var itemSpaceHorizontal: Float = 10.0

  // 格子宽度(固定宽度情况下使用)
  @State private var itemWidth = 80
  // 屏幕两边距离格子间距
  @State private var edgeSpace: Float = 20.0
  // 格子的高度
  @State private var itemHeight = 50.0
  // 格子高度是否不同
  @State private var isItemHeightDiff = false
  // 显示头部和尾部类型
  @State private var grideExtensionType: GridExtensionType = .none

  // 格子宽度是否随机
  @State private var isItemWidthRandom = false
  // 存放所有格子的宽度(随机宽度使用)
  private var itemRandomWidths: [Float] {
    var tmpArr: [Float] = []
    for _ in 0..<itemCount {
      // 获取随机宽度
      let itemW = Float.random(in: 1..<10)
      tmpArr.append(itemW)
    }
    return tmpArr
  }

  // 格子高度是否随机
  @State private var isItemHeightRandom = false
  // 存放所有格子的高度(随机高度使用)
  private var itemRandomHeights: [Float] {
    var tmpArr: [Float] = []
    for _ in 0..<itemCount {
      // 获取随机宽度
      let tempH = Float.random(in: 10..<100)
      tmpArr.append(tempH)
    }
    return tmpArr
  }

  var body: some View {
    VStack {
      // 设置视图
      settingViews

      ScrollView(.horizontal) {
        Section(
          header: GridHeader(grideExtensionType: $grideExtensionType),
          footer: GridFooter(grideExtensionType: $grideExtensionType)
        ) {
          LazyHGrid(
            rows: items,
            spacing: CGFloat(itemSpaceHorizontal),
            pinnedViews: grideExtensionList
          ) {
            if isItemWidthRandom {
              ForEach(0..<itemCount, id: \.self) { index in
                // 宽度随机
                let randomWidth = itemRandomWidths[index]
                Rectangle()
                  .cornerRadius(5)
                  .foregroundColor(.blue)
                  .frame(width: CGFloat(randomWidth))
                  .overlay {
                    Text("\(index)")
                      .foregroundColor(.white)
                  }
              }
            }
            else {
              // 宽度固定
              ForEach(0..<itemCount, id: \.self) { index in
                Rectangle()
                  .cornerRadius(5)
                  .foregroundColor(.blue)
                  .frame(width: CGFloat(itemWidth))
                  .overlay {
                    Text("\(index)")
                      .foregroundColor(.white)
                  }
              }
            }
          }
          .padding(.horizontal, CGFloat(edgeSpace))
        }
      }
    }
    .navigationTitle("LazyHGrid")
  }

  // 获取items
  var items: [GridItem] {
    // 盛放items的数组
    var tempItems: [GridItem] = []
    for i in 0..<rowCount {
      if isItemHeightDiff {
        // 高度不同(flexiable和adaptive)
        if i % 2 == 0 {
          tempItems.append(GridItem(.adaptive(minimum: 20), spacing: CGFloat(itemSpaceVertical)))
        }
        else {
          tempItems.append(GridItem(.flexible(), spacing: CGFloat(itemSpaceHorizontal)))
        }
      }
      else if isItemHeightRandom {
        // 高度随机
        let randomHeight: Float = itemRandomHeights[i]
        tempItems.append(
          GridItem(.fixed(CGFloat(randomHeight)), spacing: CGFloat(itemSpaceVertical))
        )
      }
      else {
        tempItems.append(GridItem(.fixed(itemHeight), spacing: CGFloat(itemSpaceVertical)))
      }
    }
    return tempItems
  }

  // 设置views
  var settingViews: some View {
    Form {
      Section(header: Text("设置")) {
        // 头部和尾部是否显示
        Picker("头尾显示", selection: $grideExtensionType) {
          ForEach(GridExtensionType.allCases) { type in
            Text(type.value).tag(type)
          }
        }

        // 格子个数
        Stepper("格子个数: \(itemCount)") {
          // 增加
          itemCount += 5
        } onDecrement: {
          // 减少
          itemCount -= 5
        }

        // 格子行数
        Stepper("格子行数: \(rowCount)") {
          // 增加
          rowCount += 1
        } onDecrement: {
          // 减少
          rowCount -= 1
        }

        // 边缘间距
        Stepper("边缘间距: " + String(format: "%.1f", edgeSpace)) {
          // 增加
          edgeSpace += 1.5
        } onDecrement: {
          // 减少
          edgeSpace -= 1.5
        }

        // 高度
        Stepper("格子高度: " + String(format: "%d", Int(itemHeight))) {
          // 增加
          itemHeight += 10
        } onDecrement: {
          // 减少
          itemHeight -= 10
        }

        // 水平间距
        Stepper("格子水平间距: " + String(format: "%.1f", itemSpaceHorizontal)) {
          // 增加
          itemSpaceHorizontal += 0.5
        } onDecrement: {
          // 减少
          itemSpaceHorizontal -= 0.5
        }

        // 垂直间距
        Stepper("格子垂直间距: " + String(format: "%.1f", itemSpaceVertical)) {
          // 增加
          itemSpaceVertical += 5.5
        } onDecrement: {
          // 减少
          itemSpaceVertical -= 5.5
        }

        // 格子高度不同(flexiable和adaptive)
        Toggle(isOn: $isItemHeightDiff) {
          Text("格子高度不同(flexiable和adaptive)")
        }

        // 格子高度随机
        Toggle(isOn: $isItemHeightRandom) {
          Text("格子高度随机")
        }

        // 格子宽度随机
        Toggle(isOn: $isItemWidthRandom) {
          Text("格子宽度随机")
        }

      }
    }
  }

  // 头部和尾部显示类型
  var grideExtensionList: PinnedScrollableViews {
    switch grideExtensionType {
    case .none:
      return []
    case .all:
      return [.sectionHeaders, .sectionFooters]
    case .header:
      return [.sectionHeaders]
    case .footer:
      return [.sectionFooters]
    }
  }
}
