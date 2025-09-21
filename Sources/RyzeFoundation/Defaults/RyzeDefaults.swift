//
//  RyzeDefaults.swift
//  Ryze
//
//  Created by Rafael Escaleira on 13/09/25.
//


public struct RyzeDefaults {
    var userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = UserDefaults(suiteName: "ryze.defaults") ?? .standard) {
        self.userDefaults = userDefaults
    }
    
    public func get<Value: Codable>(for key: String) -> Value? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(Value.self, from: data)
    }
    
    public func set<Value: Codable>(_ value: Value?, for key: String) {
        guard let data = try? value.data() else { return }
        userDefaults.set(data, forKey: key)
    }
}
