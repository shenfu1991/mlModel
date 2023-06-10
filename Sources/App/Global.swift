//
//  File.swift
//  
//
//  Created by Zhihong Meng on 2023/6/11.
//

import Vapor

var kApp: Application!

struct MLKey: LockKey { }
let mlKey = kApp.locks.lock(for: MLKey.self)

var MLInfo: [String: String] = [:]
