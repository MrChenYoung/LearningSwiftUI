//
//  HomeListModel.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/4/8.
//

import SwiftUI

struct HomeListModel: Hashable, Codable, Identifiable {
    var id: Self { self }
    
    // 标题
    var title: String
    // 副标题
    var subTitle: String?
    // 子节点
    var children: [HomeListModel]?
}
