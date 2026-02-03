//
//  RyzeNetworkLogger.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/07/25.
//

import RyzeFoundation

struct RyzeNetworkLogger {
    var logger: Logger
    
    init(logger: Logger = .init()) {
        self.logger = logger
    }
    
    func info(_ message: String) {
        logger.info("\(message)")
    }
    
    func warning(_ message: String) {
        logger.warning("\(message)")
    }
    
    func error(_ message: String) {
        logger.error("\(message)")
    }
}
