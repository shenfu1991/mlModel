//
//  File.swift
//  
//
//  Created by xuanyuan on 2023/6/2.
//

import Vapor


struct AddUserModel: Content {
    var msg: String?
    var success: Bool
    var num: Int?
}
