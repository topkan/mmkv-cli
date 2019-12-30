//
//  main.swift
//  mmkv-cli
//
//  Created by Tomi Kankaanpää on 28.12.2019.
//  Copyright © 2019 Tomi Kankaanpää. All rights reserved.
//

import Foundation
import Commander

Group {
  $0.command("keys",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             description: "Enumerate keys in store"
  ) { path, id in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    mmkv.enumerateKeys() { key, stop in print(key) }
  }

  $0.command("get",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             Argument<String>("key", description: "Name of the key to get"),
             description: "Get key value"
  ) { path, id, key in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    print(mmkv.string(forKey: key) ?? "no value")
  }

  $0.command("set",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             Argument<String>("key", description: "Name of the key to set"),
             Argument<String>("value", description: "Value to set"),
             description: "Set key value"
  ) { (path, id, key, value) in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    mmkv.set(value, forKey: key)
  }
}.run("0.1.0")

