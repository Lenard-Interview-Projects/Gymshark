//
//  NetworkingProtocol.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 23/08/2023.
//

import Foundation
import Combine

public protocol NetworkingProtocol {
    func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error>
}
