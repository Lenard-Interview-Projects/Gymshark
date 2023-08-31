//
//  AvailableSizes.swift
//  GymsharkServices
//
//  Created by Lenard Pop on 29/08/2023.
//

public enum AvailableSizes: String {
    case XS = "xs"
    case S = "s"
    case M = "m"
    case L = "l"
    case XL = "xl"
    case XXL = "xxl"

    public func equal(to otherType: AvailableSizes) -> Bool {
        return self == otherType
    }
}
