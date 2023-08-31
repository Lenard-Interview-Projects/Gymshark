//
//  SearchSortBy.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 22/08/2023.
//

import Foundation

public enum SearchSortBy {
    case Relevancy
    case Newest
    case PriceLowToHigh
    case PriceHighToLow

    public func equal(to otherType: SearchSortBy) -> Bool {
        return self == otherType
    }

    public func toString() -> String {
        switch self {
        case .Newest:
            return "Newest"
        case .PriceHighToLow:
            return "Price High To Low"
        case .PriceLowToHigh:
            return "Price Low To High"
        case .Relevancy:
            return "Relevancy"
        }
    }
}
