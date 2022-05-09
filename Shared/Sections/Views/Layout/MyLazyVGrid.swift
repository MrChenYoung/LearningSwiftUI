//
//  MyLazyVGrid.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/3/31.
//

import SwiftUI

struct MyLazyVGrid: View {
  // 格子的个数
  @State private var itemCount = 10
  // 列数
  @State private var columnCount = 3
  // 两个格子水平方向间距
  @State private var itemSpaceHorizontal: Float = 10.0
  // 两个格子垂直方向间距
  @State private var itemSpaceVertical: Float = 20.0
  // 屏幕两边距离格子间距
  @State private var edgeSpace: Float = 20.0
  // 格子的高度
  @State private var itemH = 50.0
  // 显示头部和尾部类型
  @State private var grideExtensionType: GridExtensionType = .none

  // 格子宽度是否不同
  @State private var isItemWidthDiff = false

  // 格子宽度是否随机
  @State private var isItemWidthRandom = false
  // 存放所有格子的宽度(随机宽度使用)
  private var itemRandomWidths: [Float] {
    var tmpArr: [Float] = []
    for _ in 0..<itemCount {
      // 获取随机宽度
      let itemW = Float.random(in: 10..<itemAverageWidth)
      tmpArr.append(itemW)
    }
    return tmpArr
  }

  // 格子是否是随机高度
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
      // 设置项
      settingViews

      ScrollView {
        LazyVGrid(
          columns: items,
          spacing: CGFloat(itemSpaceVertical),
          pinnedViews: grideExtensionList
        ) {
          Section(
            header: GridHeader(grideExtensionType: $grideExtensionType),
            footer: GridFooter(grideExtensionType: $grideExtensionType)
          ) {
            ForEach(0..<itemCount, id: \.self) { index in
              // 获取随机高度
              let randomHeight: Float = itemRandomHeights[index]

              if isItemHeightRandom {
                Rectangle()
                  .cornerRadius(5)
                  .foregroundColor(.blue)
                  .frame(height: CGFloat(randomHeight))
                  .overlay {
                    Text("\(index)")
                      .foregroundColor(.white)
                  }
              }
              else {
                Rectangle()
                  .cornerRadius(5)
                  .foregroundColor(.blue)
                  .frame(height: itemH)
                  .overlay {
                    Text("\(index)")
                      .foregroundColor(.white)
                  }
              }
            }
          }
        }
      }
    }
    .navigationTitle("LazyVGrid")
  }

  // 设置views
  var settingViews: some View {
    // 可调整的参数
    Form {
      Section(header: Text("设置")) {
        // 头部和尾部是否显示
        Picker("头尾显示", selection: $grideExtensionType) {
          ForEach(GridExtensionType.allCases) { type in
            Text(type.value).tag(type)
          }
        }

        // 格子的总个数
        Stepper {
          // 增加
          itemCount += 5
        } onDecrement: {
          // 减少
          itemCount -= 5
        } label: {
          Text("格子个数: \(itemCount)")
        }

        // 格子的列数
        Stepper {
          columnCount += 1
        } onDecrement: {
          columnCount -= 1
        } label: {
          Text("格子列数: \(columnCount)")
        }

        // 边缘间距
        Stepper {
          edgeSpace += 0.5
        } onDecrement: {
          edgeSpace -= 0.5
        } label: {
          Text("边缘间距: " + String(format: "%.1f", edgeSpace))
        }

        // 格子高度
        Stepper {
          itemH += 1
        } onDecrement: {
          itemH -= 1
        } label: {
          Text("格子高度: " + String(format: "%.f", itemH))
        }

        // 格子水平间距
        Stepper {
          itemSpaceHorizontal += 0.5
        } onDecrement: {
          itemSpaceHorizontal -= 0.5
        } label: {
          Text("格子水平间距: " + String(format: "%.1f", itemSpaceHorizontal))
        }

        // 格子垂直间距
        Stepper {
          itemSpaceVertical += 1
        } onDecrement: {
          itemSpaceVertical -= 1
        } label: {
          Text("格子垂直间距: " + String(format: "%.1f", itemSpaceVertical))
        }

        // 格子宽度是否不同
        Toggle(isOn: $isItemWidthDiff) {
          Text("格子宽度不同(flexible和adaptive)")
        }

        // 格子的宽度是否随机
        Toggle(isOn: $isItemWidthRandom) {
          Text("格子宽度随机")
        }

        // 是否开启格子随机高度
        Toggle(isOn: $isItemHeightRandom) {
          Text("格子高度随机")
        }
      }
    }
  }

  // 获取items
  var items: [GridItem] {
    // 每个格子的宽度
    let itemW = self.itemAverageWidth

    // 盛放items的数组
    var tempItems: [GridItem] = []
    for i in 0..<columnCount {
      if isItemWidthDiff {
        // 宽度不同
        if i % 2 == 0 {
          tempItems.append(GridItem(.adaptive(minimum: 20), spacing: CGFloat(itemSpaceHorizontal)))
        }
        else {
          tempItems.append(GridItem(.flexible(), spacing: CGFloat(itemSpaceHorizontal)))
        }
      }
      else if isItemWidthRandom {
        // 宽度随机
        let tmpW: Float = itemRandomWidths[i]
        tempItems.append(GridItem(.fixed(CGFloat(tmpW)), spacing: CGFloat(itemSpaceHorizontal)))
      }
      else if isItemHeightRandom {
        // 高度随机时，设置对齐方式
        tempItems.append(
          GridItem(.fixed(CGFloat(itemW)), spacing: CGFloat(itemSpaceHorizontal), alignment: .top)
        )
      }
      else {
        // 其他情况
        tempItems.append(GridItem(.fixed(CGFloat(itemW)), spacing: CGFloat(itemSpaceHorizontal)))
      }
    }
    return tempItems
  }

  // 平均每个格子的宽度
  var itemAverageWidth: Float {
    // 一行内格子所有间距的和，包括边缘间距
    let itemTotalSpace = edgeSpace * 2.0 + itemSpaceHorizontal * (Float(columnCount) - 1.0)

    return (Float(ScreenW) - itemTotalSpace) / Float(columnCount)
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

// 头部
struct GridHeader: View {
  @Binding var grideExtensionType: GridExtensionType

  var body: some View {
    switch grideExtensionType {
    case .none, .footer:
      EmptyView()
    case .all, .header:
      Text("头部")
    }
  }
}

// 尾部
struct GridFooter: View {
  @Binding var grideExtensionType: GridExtensionType

  var body: some View {
    switch grideExtensionType {
    case .none, .header:
      EmptyView()
    case .all, .footer:
      Text("尾部")
    }
  }
}

// 头部和尾部类型
enum GridExtensionType: String, CaseIterable, Identifiable {
  var id: String { self.rawValue }

  case none
  case all
  case header
  case footer

  var value: String {
    switch self {
    case .none:
      return "全不显示"
    case .all:
      return "全显示"
    case .header:
      return "头部"
    case .footer:
      return "尾部"
    }
  }
}
