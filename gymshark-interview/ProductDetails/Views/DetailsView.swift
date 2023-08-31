//
//  ProductDetailsView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 30/08/2023.
//

import SwiftUI
import UIKit
import GymsharkServices

struct ProductDetailsView: View {
    @StateObject private var viewModel: ProductDetailsViewModel
    @State private var imageSelected: Int = 0

    init(product: ProductModel) {
        _viewModel = StateObject(wrappedValue: ProductDetailsViewModel(product: product))
    }

    private func calculateWhichImageIsVisible(scrollPosition: CGFloat, itemWidth: CGFloat) -> Int {
        let positiveOffset = scrollPosition * -1
        let itemVisible = positiveOffset / itemWidth
        let roundedValue = itemVisible.rounded()

        return (Int)(roundedValue)
    }

    private func sizeRowView(sizes: [(String, Bool)], count: Int) -> some View {
        HStack {
            ForEach(sizes, id: \.0) { sizeItem in
                BorderedSelectionItemView(selection: .constant([]), title: sizeItem.0.uppercased(), isDisabled: sizeItem.1)
            }

            ForEach(0..<(4 - count), id: \.self) { index in
                VStack { }
                    .frame(maxWidth: .infinity)
            }
        }
    }

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        GeometryReader { geometry in
                            Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .global).minX)
                        }
                        .frame(height: 1)

                        HStack(spacing: 16) {
                            ForEach(viewModel.product.media, id:\.id) { item in
                                DefaultAsyncImage(url: item.src,
                                                  width: proxy.size.width,
                                                  height: proxy.size.height / 1.75,
                                                  fixedSize: true)
                            }
                        }
                    }
                    .onPreferenceChange(ViewOffsetKey.self) { offset in
                        imageSelected = calculateWhichImageIsVisible(scrollPosition: offset,
                                                                     itemWidth: proxy.size.width)
                    }
                }

                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.product.media.indices, id:\.self) { index in
                                DefaultAsyncImage(url: viewModel.product.media[index].src, width: 75, height: 100)
                                    .border(index == imageSelected ? Color.black : Color.clear)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.product.title.uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)

                        if !viewModel.product.colour.isEmpty {
                            Text(viewModel.product.colour)
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                        }

                        if !viewModel.product.type.isEmpty {
                            Text(viewModel.product.type)
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                        }

                        if let fit = viewModel.product.fit {
                            Text(fit)
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(Color.gray)
                        }

                        Text("£\(viewModel.product.price)")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 16)

                    VStack {
                        HStack {
                            Text("SELECT SIZE")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)

                            Spacer()

                            Button(action: { }) {
                                HStack(spacing: 0) {
                                    Image(systemName: "figure.stand")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(Color.black)

                                    Text("Size Guide")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .underline()
                                        .foregroundColor(Color.black)
                                }
                            }

                        }

                        VStack(alignment: .leading) {
                            ForEach(viewModel.getAllSizes().indices, id: \.self) { sizesIndex in
                                HStack {
                                    let sizes = viewModel.getAllSizes()[sizesIndex]
                                    let count = sizes.count

                                    sizeRowView(sizes: sizes, count: count)
                                }
                                .padding(.top, 2)
                            }

                            Text("Size out of stock?")
                                .font(.caption)
                                .fontWeight(.bold)
                                .underline()
                                .foregroundColor(Color.black)
                                .padding(.top, 16)
                        }
                        .padding(.bottom, 16)

                        VStack {
                            PrimaryButton(title: "Add to bag".uppercased(), icon: "bag.fill", action: {})
                            SecondaryButton(title: "Add to wishlist".uppercased(), icon: "heart", action: {})
                        }
                        .padding(.top, 16)

                        DisclosureGroup {
                            TextHtml(viewModel.product.description)
                                .padding(.top, 16)
                        }
                        label: {
                            Text("DESCRIPTION")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                        .padding(.top, 32)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(viewModel.product.title)
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: ProductModel())
    }
}
