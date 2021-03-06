//
//  Logger.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/7.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    let log: XCGLogger = XCGLogger.default

    log.setup(level: .debug, showLogIdentifier: true, showFunctionName: true,
              showThreadName: true, showLevel: true, showFileNames: true,
              showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel: .debug)

    let logFormat: PrePostFixLogFormatter = PrePostFixLogFormatter()

    logFormat.apply(prefix: "đ¯đ¯đ¯", postfix: "đ¯đ¯đ¯", to: .verbose)
    logFormat.apply(prefix: "đšđšđš", postfix: "đšđšđš", to: .debug)
    logFormat.apply(prefix: "âšī¸âšī¸âšī¸", postfix: "âšī¸âšī¸âšī¸", to: .info)
    logFormat.apply(prefix: "â ī¸â ī¸â ī¸", postfix: "â ī¸â ī¸â ī¸", to: .warning)
    logFormat.apply(prefix: "âââ", postfix: "âââ", to: .error)
    logFormat.apply(prefix: "đĨđĨđĨ", postfix: "đĨđĨđĨ", to: .severe)

    log.formatters = [logFormat]

    return log
}()
