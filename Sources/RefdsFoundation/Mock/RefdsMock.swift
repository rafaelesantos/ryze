//
//  RefdsMock.swift
//  Refds
//
//  Created by Rafael Escaleira on 25/04/25.
//

public protocol RefdsMock {
    static var mock: Self { get }
    static var mocks: [Self] { get }
}

public extension RefdsMock {
    static var mocks: [Self] {
        (1 ... 10).map { _ in
            mock
        }
    }
}
