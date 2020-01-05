//
//  String+truncate.swift
//  mmkv-cli
//
//  Created by Tomi Kankaanpää on 3.1.2020.
//  Copyright © 2020 Tomi Kankaanpää. All rights reserved.
//

import Foundation

extension String {
  enum TruncationPosition {
    case head
    case middle
    case tail
  }

  func truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "...") -> String {
    guard self.count > limit else { return self }

    switch position {
    case .head:
      return leader + self.suffix(limit)
    case .middle:
      let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))
      let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))
      return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
    case .tail:
      return self.prefix(limit) + leader
    }
  }
}
