//
//  DefaultAsyncImage.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 31/08/2023.
//

import SwiftUI

struct DefaultAsyncImage: View {
    var url: String
    var width: CGFloat
    var height: CGFloat
    var contentMode: ContentMode = .fill
    var fixedSize: Bool = false
    var withMissingImage: Bool = false

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .padding(16)
                    .frame(maxWidth: fixedSize ? nil : width, maxHeight: fixedSize ? nil : height)
                    .frame(width: fixedSize ? width : nil, height: fixedSize ? height : nil)
                    .background(.gray)

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(maxWidth: fixedSize ? nil : width, maxHeight: fixedSize ? nil : height)
                    .frame(width: fixedSize ? width : nil, height: fixedSize ? height : nil)
                    .clipped()

            case .failure(_):
                if withMissingImage {
                    Image("missing_product")
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .frame(maxWidth: fixedSize ? nil : width, maxHeight: fixedSize ? nil : height)
                        .frame(width: fixedSize ? width : nil, height: fixedSize ? height : nil)
                        .clipped()
                }

            @unknown default:
                EmptyView()
            }
        }
    }
}

struct DefaultAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        DefaultAsyncImage(url: "https://cdn.shopify.com/s/files/1/0098/8822/files/TRAININGFLEECEJOGGER-LightGreyCoreMarl-B7A4D-GBCN-0265_1920x.jpg?v=1687869210",
                          width: 250,
                          height: 250,
                          fixedSize: true)
        DefaultAsyncImage(url: "https://cdn.shopify.com/s/files/1/0098/8822/files/TRAININGFLEECEJOGGER-LightGreyCoreMarl-B7A4D-GBCN-0265_1920x.jpg?v=1687869210",
                          width: .infinity,
                          height: .infinity,
                          fixedSize: false)
    }
}
