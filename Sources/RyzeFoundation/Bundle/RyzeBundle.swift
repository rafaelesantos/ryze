//
//  RyzeBundle.swift
//  Ryze
//
//  Created by Rafael Escaleira on 24/03/25.
//

@_exported import Foundation

public actor RyzeBundle {
    public var applicationName: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    public var applicationIdentifier: String? {
        Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    
    public var applicationVersion: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var applicationBuild: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var operatingSystemVersion: OperatingSystemVersion {
        ProcessInfo.processInfo.operatingSystemVersion
    }
    
    public init() {}
}
