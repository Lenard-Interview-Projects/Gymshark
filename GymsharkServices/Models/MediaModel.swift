//
//  MediaModel.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 29/08/2023.
//

public struct MediaModel: Codable {
    public let createdAt: String
    public let id: Int
    public let src: String

    public init() {
        createdAt = ""
        id = 0
        src = ""
    }

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case src = "src"
        case id = "id"
    }
}
