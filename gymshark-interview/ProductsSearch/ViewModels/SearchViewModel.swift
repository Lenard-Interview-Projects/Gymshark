//
//  SearchViewModel.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import Foundation
import Combine
import GymsharkServices
import Gymjection

class SearchViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var totalCount: Int = 0

    @Published var isInitialized = false
    @Published var canLoadMore = true
    @Published var errorFound = false
    @Published var isLoading = false
    @Published var isEmpty = false

    @Published var sortBy: SearchSortBy = .Relevancy
    @Published var selectedSizes: [String] = []
    @Published var selectedFits: [String] = []
    @Published var selectedColours: [String] = []

    private let pageSize = 20
    private var currentPage = 1
    private var cancellables: Set<AnyCancellable> = []

    @Injected private var productsServices: ProductsServicesProtocol

    public var selectedQueriesCount: Int {
        return selectedSizes.count + selectedFits.count + selectedColours.count
    }

    init() { }

    convenience init(productsServices: ProductsServicesProtocol) {
        self.init()

        self.productsServices = productsServices
    }

    deinit {
        cancelAllPublishers()
    }

    public func cancelAllPublishers() {
        cancellables.forEach({ $0.cancel() })
    }

    public func loadMore() {
        if isLoading { return }

        isLoading = true

        fetchProductsResultsFromService()
    }

    public func fetchProductsSearchResults() {
        if isInitialized { return }
        if isLoading { return }

        isLoading = true

        fetchProductsResultsFromService()
    }

    public func filterProductsSearchResults() {
        if isLoading { return }

        isLoading = true

        currentPage = 1
        products.removeAll()

        fetchProductsResultsFromService()
    }

    public func reset() {
        products.removeAll()
        totalCount = 0
        isInitialized = false
        canLoadMore = true
        errorFound = false
        isLoading = true
        isEmpty = false
        sortBy = .Relevancy
        selectedFits = []
        selectedSizes = []
        selectedColours = []

        currentPage = 1
    }

    private func fetchProductsResultsFromService() {
        var searchQueryModel = SearchQueryModel()
        searchQueryModel.text = ""
        searchQueryModel.sortBy = sortBy

        searchQueryModel.pageSize = 20
        searchQueryModel.pageCount = currentPage

        searchQueryModel.colours = selectedColours
        searchQueryModel.fits = selectedFits
        searchQueryModel.sizes = selectedSizes

        productsServices
            .fetchResults(searchQuery: searchQueryModel)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .finished:
                    self.errorFound = false
                    break
                case .failure(let error):
                    // Log the error into something like Firebase/Sentry
                    print(error)
                    self.errorFound = true
                    self.isLoading = false
                    self.canLoadMore = false
                    self.isInitialized = true
                    break;
                }
            }, receiveValue: { [weak self] (data: ProductsResponseModel) in
                guard let self = self else { return }

                self.products.append(contentsOf: data.hits)
                self.totalCount = data.totalCount
                self.isEmpty = self.products.isEmpty
                self.canLoadMore = !data.hits.isEmpty && data.hits.count >= self.pageSize

                self.isLoading = false
                self.isInitialized = true

                self.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
