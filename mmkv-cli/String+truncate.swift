//
//  String+truncate.swift
//  mmkv-cli
//
//  Created by Tomi Kankaanpää on 3.1.2020.
//  Copyright © 2020 Tomi Kankaanpää. All rights reserved.
//

import Foundation

extension String {
  func truncate(limit: Int, leader: String = "...") -> String {
    guard self.count > limit else { return self }
    return self.prefix(limit) + leader
  }
}
