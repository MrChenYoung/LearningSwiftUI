//
//  Utils.swift
//  LearningSwiftUI (iOS)
//
//  Created by MrChen on 2022/4/8.
//

import Foundation

struct Utils {
  // MARK: 读取JSON文件
  static func loadJsonFile<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
      fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
      data = try Data(contentsOf: file)
    }
    catch {
      fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    }
    catch {
      fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
  }

  // json字符串转数组
  static func jsonStringToArray<T: Decodable>(jsonString: String) -> T {
    let jsonData: Data = jsonString.data(using: .utf8)!

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: jsonData)
    }
    catch {
      fatalError("Couldn't parse  as \(T.self)")
    }
  }
    
    
}
