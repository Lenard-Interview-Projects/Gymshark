//
//  Injected.swift
//  Gymjection
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation

@propertyWrapper public struct Injected<T> {
    public var wrappedValue: T

    public init() {
        self.wrappedValue = DependecyInjection.resolve()
        print("Injected: ", self.wrappedValue)
    }
}
