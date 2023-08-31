//
//  gymshark_interviewApp.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 28/08/2023.
//

import SwiftUI
import GymsharkServices
import Gymjection

@main
struct gymshark_interviewApp: App {

    init() {
        registerDepenedencies()
    }

    private func registerDepenedencies() {
        DependecyInjection.register(dependency: ProductsServices() as ProductsServicesProtocol)
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchView()
            }
        }
    }
}
