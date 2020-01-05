//
//  main.swift
//  mmkv-cli
//
//  Created by Tomi Kankaanpää on 28.12.2019.
//  Copyright © 2019 Tomi Kankaanpää. All rights reserved.
//

import Foundation
import Commander
import SwiftyTextTable

Group {
  $0.command("keys",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             description: "Enumerate keys in store"
  ) { path, id in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    mmkv.enumerateKeys() { key, stop in print(key) }
    exit(EXIT_SUCCESS)
  }

  $0.command("get",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             Flag("prettify-json", flag: "p"),
             Argument<String>("key", description: "Name of the key to get"),
             description: "Get key value"
  ) { path, id, prettify, key in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    guard let value = mmkv.string(forKey: key) else { exit(EXIT_FAILURE) }
    print(prettify ? value.prettifiedJSON() : value)
    exit(EXIT_SUCCESS)
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
    exit(EXIT_SUCCESS)
  }

  $0.command("delete",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             Argument<String>("key", description: "Name of the key to delete"),
             description: "Delete key value"
  ) { path, id, key in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    guard mmkv.contains(key: key) else { exit(EXIT_FAILURE) }
    mmkv.removeValue(forKey: key)
    exit(EXIT_SUCCESS)
  }

  $0.command("reset",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             description: "Delete all keys"
  ) { path, id in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    mmkv.clearAll()
    exit(EXIT_SUCCESS)
  }

  $0.command("dump",
             Option<String>("path", default: "./", description: "Path to the MMKV file"),
             Option<String>("id", default: "mmkv.default", description: "Id of the MMKV file"),
             Option<Int>("truncate", default: 100, description: "Truncate value columns. Set to '0' to surpress truncation"),
             Flag("prettify-json", flag: "p"),
             description: "Dump all keys and their values"
  ) { path, id, truncate, prettify in
    let mmkv = MMKV.init(mmapID: id, relativePath: path)!
    let key = TextTableColumn(header: "Key")
    let value = TextTableColumn(header: "Value")
    var table = TextTable(columns: [key, value])
    mmkv.enumerateKeys() { key, stop in
      let value = mmkv.string(forKey: key) ?? "no value"
      let row = (prettify ? value.prettifiedJSON() : value).truncate(limit: truncate > 0 ? truncate : Int.max)
      table.addRow(values: [key, row])
    }
    print(table.render())
    exit(EXIT_SUCCESS)
  }
}.run("0.2.0")

