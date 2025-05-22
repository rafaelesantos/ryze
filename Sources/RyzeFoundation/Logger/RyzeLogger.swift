//
//  RyzeLogger.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import os

public protocol RyzeLogger {
    var logger: Logger { get }
    
    func log()
}
