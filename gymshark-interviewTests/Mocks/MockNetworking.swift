//
//  MockNetworking.swift
//  gymshark-interviewTests
//
//  Created by Lenard Pop on 02/09/2023.
//

import Foundation
import Combine
import GymsharkServices

public final class MockNetworking: NetworkingProtocol {
    var urlSession: URLSession
    var stubbedData: Result<Data, Error>?

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func withResult(result: Result<Data, Error>?) {
        self.stubbedData = result
    }

    public func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return urlSession
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
