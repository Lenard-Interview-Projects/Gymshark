//
//  SearchViewModelTests.swift
//  gymshark-interviewTests
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation
import GymsharkServices
import XCTest
@testable import gymshark_interview

class SearchViewModelTests: XCTestCase {
    var productsService: MockProductServices!
    var viewModel: SearchViewModel!

    override func setUp() {
        self.productsService = MockProductServices()
        self.viewModel = SearchViewModel(productsServices: productsService)
    }

    func test_initial_values() throws {
        // Arrange
        // Act
        // Assert
        XCTAssertEqual(0, viewModel.products.count)
        XCTAssertEqual(SearchSortBy.Relevancy, viewModel.sortBy)

        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isInitialized)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingRecentResults_valid() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseLimitedData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        // Act
        viewModel.fetchProductsSearchResults()

        // Assert
        XCTAssertEqual(10, viewModel.products.count)

        XCTAssertEqual([6732609257571, 6732607094883, 6732605882467, 6710581035107, 6703192801379, 6703192768611, 6703192703075, 6703191818339, 6703191752803, 6693927616611], viewModel.products.map({ $0.id }))

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

    func test_fetchingRecentResults_errorFound() throws {
        // Arrange
        productsService.withError()

        // Act
        viewModel.fetchProductsSearchResults()

        // Assert
        XCTAssertEqual(0, viewModel.products.count)

        XCTAssertTrue(viewModel.errorFound)
        XCTAssertTrue(viewModel.isInitialized)

        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
    }

    func test_loadMore_fetchProductsSearchResulsts() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        // Pre-Act
        viewModel.fetchProductsSearchResults()

        // Pre-Assert
        XCTAssertEqual(20, viewModel.products.count)
        XCTAssertTrue(viewModel.canLoadMore)

        // Post-Act
        viewModel.loadMore()

        // Post-Assert
        XCTAssertEqual(40, viewModel.products.count)
        XCTAssertEqual([6732609257571, 6654883364963], [viewModel.products.first?.id ?? 0, viewModel.products.last?.id ?? 0])
        XCTAssertTrue(viewModel.canLoadMore)
    }

    func test_filterProductsResults_found() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        viewModel.selectedSizes = ["xs", "s", "m"]
        viewModel.selectedColours = ["black"]

        // Act
        viewModel.filterProductsSearchResults()

        // Assert
        XCTAssertEqual(7, viewModel.totalCount)
    }

    func test_filterProductsResults_notFound() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        viewModel.selectedSizes = ["xxs"]

        // Act
        viewModel.filterProductsSearchResults()

        // Assert
        XCTAssertEqual(0, viewModel.totalCount)
    }

    func test_filterProductsResults_sortByPrice_lowToHigh() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        viewModel.sortBy = .PriceLowToHigh

        // Act
        viewModel.filterProductsSearchResults()

        // Assert
        XCTAssertEqual(6703191818339, viewModel.products.first?.id ?? -1)
    }

    func test_filterProductsResults_sortByPrice_highToLow() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        viewModel.sortBy = .PriceHighToLow

        // Act
        viewModel.filterProductsSearchResults()

        // Assert
        XCTAssertEqual(6732609257571, viewModel.products.first?.id ?? -1)
    }

    func test_filterProductsResults_sortByPrice_newest() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        viewModel.sortBy = .Newest

        // Act
        viewModel.filterProductsSearchResults()

        // Assert
        XCTAssertEqual(6693920374883, viewModel.products.first?.id ?? -1)
    }

    func test_filterProductsResults_sortByPrice_relevancy() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        viewModel.sortBy = .Relevancy

        // Act
        viewModel.filterProductsSearchResults()

        // Assert
        XCTAssertEqual(6732609257571, viewModel.products.first?.id ?? -1)
    }

    func test_reseting() throws {
        // Arrange
        let searchResponse: ProductsResponseModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductsResponseLimitedData")

        guard let searchResponse = searchResponse else {
            XCTFail("Could not convert JSON to ProductsResponseModel")
            return
        }

        productsService.withResult(productsResponseModel: searchResponse)

        // Pre-Act
        viewModel.fetchProductsSearchResults()

        // Pre-Assert
        XCTAssertEqual(10, viewModel.products.count)

        XCTAssertTrue(viewModel.isInitialized)
        XCTAssertFalse(viewModel.canLoadMore)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)

        // Post-Act
        viewModel.reset()

        // Post-Assert
        XCTAssertEqual(0, viewModel.products.count)

        XCTAssertFalse(viewModel.isInitialized)
        XCTAssertTrue(viewModel.canLoadMore)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertFalse(viewModel.errorFound)
    }

}
