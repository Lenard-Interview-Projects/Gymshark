//
//  MockProductServices.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation
import Combine

public final class MockProductServices: ProductsServicesProtocol {
    private var productsResponseModel: ProductsResponseModel?
    private var errorFound: Bool = false

    public init() { }

    public func withResult(productsResponseModel: ProductsResponseModel) {
        self.productsResponseModel = productsResponseModel
    }

    public func withError() {
        errorFound = true
    }

    public func fetchResults(searchQuery: SearchQueryModel) -> AnyPublisher<ProductsResponseModel, Error> {
        let optionalPublisher = Just(productsResponseModel)

        return optionalPublisher
            .flatMap { (data: ProductsResponseModel?) -> AnyPublisher<ProductsResponseModel, Error> in
                if let data = data, self.errorFound == false {
                    var products = data.hits
                    var totalCount = data.hits.count

                    products = self.getProductsBasedColour(products, query: searchQuery.colours)
                    products = self.getProductsBasedOnText(products, query: searchQuery.text)
                    products = self.getProductsBasedFit(products, query: searchQuery.fits)
                    products = self.getProductsBasedSize(products, query: searchQuery.sizes)
                    products = self.getProductsBasedOnSortType(products, orderBy: searchQuery.sortBy)

                    totalCount = searchQuery.anyQueriesSet() ? products.count : data.hits.count

                    // Need to get the total count before filtering the page size
                    products = self.getProductsBasedOnPage(products, pageSize: searchQuery.pageSize, pageCount: searchQuery.pageCount)

                    let pagedResult = ProductsResponseModel(hits: products, totalCount: totalCount)

                    return Just(pagedResult)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    let error = NSError(domain: "YourErrorDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Value is nil"])
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func getProductsBasedOnSortType(_ products: [ProductModel], orderBy: SearchSortBy) -> [ProductModel] {
        guard !products.isEmpty else { return products }

        switch orderBy {
        case .Relevancy:
            return products
        case .Newest:
            return products.sorted { $0.featuredMedia.createdAt > $1.featuredMedia.createdAt }
        case .PriceHighToLow:
            return products.sorted { $0.price > $1.price }
        case .PriceLowToHigh:
            return products.sorted { $0.price < $1.price }
        }
    }

    private func getProductsBasedOnText(_ products: [ProductModel], query: String) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        guard !products.isEmpty else { return products }

        return products.filter { $0.title.lowercased().contains(query.lowercased()) }
    }

    private func getProductsBasedOnPage(_ products: [ProductModel], pageSize: Int, pageCount: Int) -> [ProductModel] {
        guard pageSize != 0 else { return products }
        guard !products.isEmpty else { return products }

        if products.count > (pageSize * pageCount)
        {
            return Array(products[(pageSize * (pageCount - 1))..<(pageSize * pageCount)])
        }
        else
        {
            return Array(products[(pageSize * (pageCount - 1))..<products.count])
        }
    }

    private func getProductsBasedFit(_ products: [ProductModel], query: [String]) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        guard !products.isEmpty else { return products }

        var filteredProducts: [ProductModel] = []

        for item in query {
            filteredProducts.append(contentsOf: products.filter { $0.fit?.lowercased() == item.lowercased() })
        }

        return filteredProducts
    }

    private func getProductsBasedColour(_ products: [ProductModel], query: [String]) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        guard !products.isEmpty else { return products }

        var filteredProducts: [ProductModel] = []

        for item in query {
            filteredProducts.append(contentsOf: products.filter { $0.colour.lowercased() == item.lowercased() })
        }

        return filteredProducts
    }

    private func getProductsBasedSize(_ products: [ProductModel], query: [String]) -> [ProductModel] {
        guard !query.isEmpty else { return products }
        guard !products.isEmpty else { return products }

        var filteredProducts: [ProductModel] = []

        for product in products {
            if product.isSizeAvailable(sizes: query) {
                filteredProducts.append(product)
            }
        }

        return filteredProducts
    }
}
