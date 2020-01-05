//
//  String+JSON.swift
//  mmkv-cli
//
//  Created by Tomi Kankaanpää on 4.1.2020.
//  Copyright © 2020 Tomi Kankaanpää. All rights reserved.
//

import Foundation

extension String {
  func prettifiedJSON() -> String {
    guard let data = self.data(using: .utf8) else { return self }
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
        return (String(decoding: jsonData, as: UTF8.self))
    } else {
        return self
    }
  }
}
