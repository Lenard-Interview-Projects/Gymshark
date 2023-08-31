//
//  ProductsResponseModel.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 28/08/2023.
//

public struct ProductsResponseModel: Codable {
    public var hits: [ProductModel]
    public var totalCount: Int

    public init(hits: [ProductModel] = [], totalCount: Int = 0) {
        self.hits = hits
        self.totalCount = totalCount
    }

    /** Reason
     In order to make it a bit easier for myself I provide a custom decoder which will
     ignore the totalCount so that it doesn't fail when getting data from the API.

     Reasoning for totalCount in the first place is a simple assumption that the API should return this in the first place
     and I should only have to consume it.
     */
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hits = try container.decode([ProductModel].self, forKey: .hits)
        totalCount = 0
    }

    enum CodingKeys: String, CodingKey {
        case hits = "hits"
        case totalCount = "totalCount"
    }
}
