//
//  DetailsViewModelTests.swift
//  gymshark-interviewTests
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation
import GymsharkServices
import XCTest
@testable import gymshark_interview

class DetailsViewModelTests: XCTestCase {
    var viewModel: ProductDetailsViewModel!

    override func setUp() {
        // We are making sure to set the product to a default model before each test
        self.viewModel = ProductDetailsViewModel(product: ProductModel())
    }

    func test_initial_productModel() throws {
        // Arrange
        let product: ProductModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductModelData")

        guard let product = product else {
            XCTFail("Could not convert JSON to ProductModel")
            return
        }

        // Act
        self.viewModel = ProductDetailsViewModel(product: product)

        // Assert
        XCTAssertEqual(6732609257571, viewModel.product.id)
        XCTAssertEqual(1000, viewModel.product.price)
        XCTAssertEqual("Navy", viewModel.product.colour)
        XCTAssertEqual("Speed Leggings", viewModel.product.title)
    }

    func test_getAllSizes_grouped() throws {
        // Arrange
        let product: ProductModel? = TestUtils.shared.convertJSONtoObject(fileName: "ProductModelData")

        guard let product = product else {
            XCTFail("Could not convert JSON to ProductModel")
            return
        }

        // Act
        self.viewModel = ProductDetailsViewModel(product: product)

        // Assert
        var result = [[(String, Bool)]]()
        result.append([("xs", false),("s", true),("m", true),("l", false)])
        result.append([("xl", false),("xxl", false)])

        print(viewModel.getAllSizes())
        print(viewModel.getAllSizes()[0].map({ $0.0 }))

        XCTAssertEqual(2, viewModel.getAllSizes().count)
        XCTAssertEqual(4, viewModel.getAllSizes()[0].count)
        XCTAssertEqual(2, viewModel.getAllSizes()[1].count)

        for index in viewModel.getAllSizes().indices {
            XCTAssertEqual(result[index].map({ $0.0 }), viewModel.getAllSizes()[index].map({ $0.0 }))
            XCTAssertEqual(result[index].map({ $0.1 }), viewModel.getAllSizes()[index].map({ $0.1 }))
        }
    }
}
