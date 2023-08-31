//
//  AvailableSizeModel.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 29/08/2023.
//

public struct AvailableSizeModel: Codable {
    public let id: Int
    public let inStock: Bool
    public let size: String

    public init() {
        id = 0
        inStock = false
        size = ""
    }

    enum CodingKeys: String, CodingKey {
        case inStock = "inStock"
        case size = "size"
        case id = "id"
    }
}
