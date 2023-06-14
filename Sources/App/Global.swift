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

struct CSVKey: LockKey { }
let csvKey = kApp.locks.lock(for: CSVKey.self)

var MLInfo: [String: String] = [:]

var csvString = "open,high,low,volume,volatility,result\n"

var csvString3m = "open,high,low,volume,volatility,result\n"
var csvString5m = "open,high,low,volume,volatility,result\n"
var csvString15m = "open,high,low,volume,volatility,result\n"
var csvString30m = "open,high,low,volume,volatility,result\n"
