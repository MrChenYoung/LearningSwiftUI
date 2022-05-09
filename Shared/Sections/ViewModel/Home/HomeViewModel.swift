//
//  HomeViewModel.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/4/8.
//

import SwiftUI

class HomeViewModel {
  // 读取数据
  var homeData: [HomeListModel] {
    return Utils.loadJsonFile("Data.json")
  }
}
