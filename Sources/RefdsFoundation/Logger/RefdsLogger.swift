//
//  RefdsLogger.swift
//  Refds
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import os

public protocol RefdsLogger {
    var logger: Logger { get }
    
    func log()
}
