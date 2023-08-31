//
//  SearchOrderBy.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 22/08/2023.
//

import Foundation

public enum SearchSortBy {
    case Relevancy
    case Newest
    case PriceLow
    case PriceHigh

    public func equal(to otherType: SearchSortBy) -> Bool {
        return self == otherType
    }
}
