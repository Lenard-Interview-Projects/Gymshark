//
//  ProductDetailsViewModel.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 30/08/2023.
//

import Foundation
import Combine
import GymsharkServices

class ProductDetailsViewModel: ObservableObject {
    @Published var product: ProductModel

    init(product: ProductModel) {
        self.product = product
    }

    /**
        The method will return a an array of available sizes grouped in a number of 4
        each size will contain the Text and if its available or not.
            - String = Text
            - Bool = IsAvailable

        The bool is used to disable the button if its not available hence the bool inversion.
     
        return (String, Bool)
     */
    public func getAllSizes() -> [[(String, Bool)]] {
        var result: [[(String, Bool)]] = []
        var currentSubSizes: [(String, Bool)] = []

        for itemSize in product.availableSizes {
            currentSubSizes.append((itemSize.size, !itemSize.inStock))

            if currentSubSizes.count == 4 {
                result.append(currentSubSizes)
                currentSubSizes = []
            }
        }

        if !currentSubSizes.isEmpty {
            result.append(currentSubSizes)
        }

        return result
    }
}
