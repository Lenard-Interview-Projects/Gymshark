//
//  ProductModel.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 28/08/2023.
//

public struct ProductModel: Codable {
    public let id: Int
    public let inStock: Bool
    public let sizeInStock: [String]?
    public let availableSizes: [AvailableSizeModel]
    public let title: String
    public let type: String
    public let description: String
    public let fit: String?
    public let labels: [String]?
    public let colour: String
    public let price: Int
    public let featuredMedia: MediaModel
    public let media: [MediaModel]

    public var getSizeInStock: [String] {
        return sizeInStock ?? []
    }

    public var getLabels: [String] {
        guard let labels = labels else { return [] }

        return labels.map({ $0.replacingOccurrences(of: "-", with: " ").capitalized })
    }

    public init() {
        id = 0
        inStock = true
        sizeInStock = []
        availableSizes = []
        title = ""
        description = ""
        fit = ""
        type = ""
        labels = []
        colour = ""
        price = 0
        featuredMedia = MediaModel()
        media = []
    }

    public func isSizeAvailable(sizes: [String]) -> Bool {
        return sizes.map { $0.lowercased() }.contains { size in
            sizeInStock?.map { $0 }.contains(size) ?? false
        }
    }

    enum CodingKeys: String, CodingKey {
        case availableSizes = "availableSizes"
        case featuredMedia = "featuredMedia"
        case sizeInStock = "sizeInStock"
        case description = "description"
        case inStock = "inStock"
        case labels = "labels"
        case colour = "colour"
        case title = "title"
        case price = "price"
        case media = "media"
        case type = "type"
        case fit = "fit"
        case id = "id"
    }
}
