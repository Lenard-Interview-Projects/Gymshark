//
//  ProductsServicesProtocol.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 18/08/2023.
//

import Foundation
import Combine

public protocol ProductsServicesProtocol {
    func fetchResults(searchQuery: SearchQueryModel) -> AnyPublisher<ProductsResponseModel, Error>
}
