//
//  RyzeNetworkLogger.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/07/25.
//

import RyzeFoundation

struct RyzeNetworkLogger: RyzeSystemLogger {
    typealias Message = RyzeNetworkLogMessage
    var logger: Logger
    
    init (logger: Logger = .init()) {
        self.logger = logger
    }
    
    func info(_ message: Message) {
        logger.info("\(message.value)")
    }
    
    func warning(_ message: Message) {
        logger.warning("\(message.value)")
    }
    
    func error(_ message: Message) {
        logger.error("\(message.value)")
    }
}
