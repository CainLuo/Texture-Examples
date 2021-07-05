//
//  ErrorType.swift
//  Woya
//
//  Created by YYKJ0048 on 2020/4/27.
//  Copyright © 2020 ve2. All rights reserved.
//

import Foundation

public enum ErrorCode: Int {
    case unknown
    case invalidPassword
    case result
    case business
    case ipRestricted
    case illegalRequest
    case timeout
}

/// 创建自定义的Error
/// - Parameters:
///   - code: ErrorCode
///   - message: String
/// - Returns: NSError
public func newError(_ code: ErrorCode, message: String? = nil) -> NSError {
    
    let errorDomain: String = "com.litalk.messager.error"
    
    let userInfo: [String: Any] = [NSLocalizedDescriptionKey: message ?? ""]
    return NSError(domain: errorDomain, code: code.rawValue, userInfo: userInfo)
}
