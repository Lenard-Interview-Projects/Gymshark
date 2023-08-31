//
//  Networking.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 18/08/2023.
//

import Foundation
import Combine

public class Networking: NetworkingProtocol {
    
    public init() { }

    public func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
