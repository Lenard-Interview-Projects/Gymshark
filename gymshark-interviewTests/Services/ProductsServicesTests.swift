//
//  ProductsServicesTests.swift
//  gymshark-interviewTests
//
//  Created by Lenard Pop on 02/09/2023.
//

import Foundation
import GymsharkServices
import XCTest

class ProductsServicesTests: XCTestCase {
    var urlSession: URLSession!
    var networking: MockNetworking!
    var services: ProductsServices!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        self.urlSession = URLSession.init(configuration: configuration)

        self.networking = MockNetworking(urlSession: urlSession)
        self.services = ProductsServices(networking: networking)
    }

    func test_fetchResult_success() throws {
        // Arrange
        let expectation = expectation(description: "Fetching results")
        let searchQuery = SearchQueryModel(text: "",
                                           pageCount: 1,
                                           pageSize: 20,
                                           sortBy: .Relevancy,
                                           colours: [],
                                           sizes: [],
                                           fits: [])

        let apiURL = URL(string: "https://cdn.develop.gymshark.com/training/mock-product-responses/algolia-example-payload.json")!
        let apiData = TestUtils.shared.getJSONData(fileName: "ProductsResponseLimitedData")

        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == apiURL else {
                throw URLError(.badURL)
            }

            let response = HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, apiData)
        }

        // Act
        let cancellable = services
            .fetchResults(searchQuery: searchQuery)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected a success response, but received an error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { model in

                // Assert
                XCTAssertEqual(10, model.totalCount)
            })

        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }

    func test_fetchResult_failure() throws {
        // Arrange
        let expectation = expectation(description: "Fetching results")
        let searchQuery = SearchQueryModel(text: "",
                                           pageCount: 1,
                                           pageSize: 20,
                                           sortBy: .Relevancy,
                                           colours: [],
                                           sizes: [],
                                           fits: [])

        MockURLProtocol.requestHandler = { request in
            throw URLError(.badURL)
        }

        // Act
        let cancellable = services
            .fetchResults(searchQuery: searchQuery)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Assert
                    
                    XCTFail("Expected an error, but received a success response.")
                case .failure(let error):

                    // Assert
                    XCTAssertEqual((error as! URLError).code, URLError(.badURL).code)
                    XCTAssertEqual((error as! URLError).localizedDescription, URLError(.badURL).localizedDescription)
                }

                expectation.fulfill()
            }, receiveValue: { _ in })

        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
    }
}
