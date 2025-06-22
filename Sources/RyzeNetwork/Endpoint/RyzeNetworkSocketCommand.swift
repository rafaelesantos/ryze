//
//  RyzeNetworkSocketCommand.swift
//  Ryze
//
//  Created by Rafael Escaleira on 22/06/25.
//

public protocol RyzeNetworkSocketCommand: Sendable {
    var message: String { get }
}
