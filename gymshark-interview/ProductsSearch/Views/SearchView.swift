//
//  SearchView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI
import GymsharkServices

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    @State private var isSelected: Bool = false
    @State private var isFiltering: Bool = false

    @State private var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)

    init() {
        _viewModel = StateObject(wrappedValue: SearchViewModel())
    }

    var body: some View {
        ScrollView(viewModel.isInitialized ? .vertical : []) {
            VStack {
                controlProductButtons()

                if viewModel.errorFound {
                    errorStateView()
                }
                else if viewModel.isEmpty {
                    emptyStateView()
                }
                else {
                    LazyVGrid(columns: columns) {
                        if !viewModel.isInitialized {
                            ForEach(0..<6, id:\.self) { _ in
                                SearchItemView(product: ProductModel(), isSelected: isSelected)
                                    .redacted(reason: .placeholder)
                            }
                        }
                        else {
                            ForEach(viewModel.products, id:\.id) { product in
                                NavigationLink(destination: ProductDetailsView(product: product)) {
                                    SearchItemView(product: product, isSelected: isSelected)
                                }
                            }
                        }

                        /** WhatNext
                         Rather than adding a progress view I would've use a framework called introspect to be able to get more information from the scrollview
                         and I would then detect when the users are near the bottom, that's when we load more content.

                         By doing so we can move the progress view outside the LazyVGrid and center it in the view.
                         */
                        if viewModel.isInitialized && viewModel.canLoadMore {
                            ProgressView()
                                .onAppear {
                                    viewModel.loadMore()
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 16)
                        }
                    }
                }
            }
            .padding(16)
            .navigationTitle("Found \(viewModel.totalCount) cards")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isFiltering, onDismiss: { viewModel.filterProductsSearchResults() }) {
                SearchFilterAndSortView(sortBy: $viewModel.sortBy,
                                        selectedSizes: $viewModel.selectedSizes,
                                        selectedFits: $viewModel.selectedFits,
                                        selectedColours: $viewModel.selectedColours)
            }
            .onAppear {
                viewModel.fetchProductsSearchResults()
            }
            .onDisappear {
                viewModel.cancelAllPublishers()
            }
        }
    }

    private func controlProductButtons() -> some View {
        HStack {
            GridSizeToggleView(isSelected: $isSelected)
                .onChange(of: isSelected) { newValue in
                    columns = Array(repeating: GridItem(.flexible()), count: newValue ? 1 : 2)
                }

            Button(action: { isFiltering.toggle() }) {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 25)
                    .foregroundColor(Color.black)

                Text("FILTER & SORT")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 6)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(25)
            .overlay(alignment: .topTrailing) {
                if viewModel.selectedQueriesCount > 0 {
                    Text("+\(viewModel.selectedQueriesCount)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(6)
                        .background(Color.blue)
                        .cornerRadius(25)
                        .offset(x: 5, y: -5)
                }
            }
        }
    }

    private func emptyStateView() -> some View {
        VStack {
            Image("missing_image")
                .resizable()
                .scaledToFit()

            Text("No products have been found, sorry.")
                .font(.body)
                .fontWeight(.light)
                .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorStateView() -> some View {
        VStack {
            Image("missing_image")
                .resizable()
                .scaledToFit()

            Button(action: {
                viewModel.reset()
                viewModel.loadMore()
            }, label: {
                Text("There was an error click **here** to try again")
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
