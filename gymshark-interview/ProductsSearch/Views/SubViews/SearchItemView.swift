//
//  SearchItemView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI
import GymsharkServices

struct SearchItemView: View {
    var product: ProductModel
    var isSelected: Bool = false

    private let smallHeightSize: CGFloat = 200
    private let largeHeightSize: CGFloat = 500

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DefaultAsyncImage(url: product.featuredMedia.src,
                              width: .infinity,
                              height: isSelected ? largeHeightSize : smallHeightSize,
                              withMissingImage: true)
            .overlay(alignment: .bottomLeading) {
                if !product.inStock {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .fill(Color.red.opacity(0.3))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        Text("NOT IN STOCK")
                            .font(.title3)
                            .fontWeight(.light)
                            .foregroundColor(Color.white)
                    }
                }
                else {
                    if !product.getLabels.isEmpty {
                        ForEach(product.getLabels, id:\.self) { label in
                            HStack(spacing: 8) {
                                Text(label)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .frame(minWidth: 50)
                                    .padding(4)
                                    .background(Color.white)
                                    .padding(8)
                            }
                        }
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .lineLimit(2)

                Text(product.colour)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)

                Text("£\(product.price)")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
            .padding(12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(product: ProductModel())
    }
}
