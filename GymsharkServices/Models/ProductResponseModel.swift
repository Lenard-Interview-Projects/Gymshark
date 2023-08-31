//
//  ProductResponseModel.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 28/08/2023.
//

public struct ProductsResponseModel: Codable {
    public var hits: [ProductModel]

    public init(hits: [ProductModel] = []) {
        self.hits = hits
    }

    enum CodingKeys: String, CodingKey {
        case hits = "hits"
    }
}
