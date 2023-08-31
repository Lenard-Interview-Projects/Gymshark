//
//  SearchQueryModel.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 29/08/2023.
//

import Foundation

public struct SearchQueryModel {
    public var text: String = ""
    public var pageCount: Int = 0
    public var pageSize: Int = 0

    public var sortBy: SearchSortBy = .Relevancy
    
    public var colours: [String] = []
    public var sizes: [String] = []
    public var fits: [String] = []

    public init() { }

    public init(text: String, pageCount: Int, pageSize: Int, sortBy: SearchSortBy, colours: [String], sizes: [String], fits: [String]) {
        self.text = text
        self.pageCount = pageCount
        self.pageSize = pageSize
        self.sortBy = sortBy
        self.colours = colours
        self.sizes = sizes
        self.fits = fits
    }

    public func anyQueriesSet() -> Bool {
        return !text.isEmpty || pageCount != 0 || pageSize != 0 || sortBy != .Relevancy || !colours.isEmpty || !sizes.isEmpty || !fits.isEmpty
    }
}
