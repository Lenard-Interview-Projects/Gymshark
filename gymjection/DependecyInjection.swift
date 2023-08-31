//
//  DependecyInjection.swift
//  Gymjection
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation

public struct DependecyInjection {
    public static let shared = DependecyInjection()
    private static var dependeciesList: [String:Any] = [:]

    // Attempts to retrieve the dependency. If it doesn't exist we throw a fatal error.
    public static func resolve<T>() -> T {
        guard let t = dependeciesList[String(describing: T.self)] as? T else {
            fatalError("No provider registered for type \(T.self)")
        }

        return t
    }

    // Creates a new item in a dictionary where T being the key as string, and T being the actual value.
    public static func register<T>(dependency: T) {
        dependeciesList[String(describing: T.self)] = dependency
        print("Registering a new dependency:", T.self)
    }
}
