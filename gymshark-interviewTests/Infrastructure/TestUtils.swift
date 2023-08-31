//
//  TestUtils.swift
//  gymshark-interviewTests
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation
import XCTest

public class TestUtils {
    public static let shared = TestUtils()

    private init () {}

    public func convertJSONtoObject<T: Decodable>(fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            XCTFail("Could not read contents of file")
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: jsonData)
    }

    public func getJSONData(fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            XCTFail("Could not read contents of file")
            return nil
        }

        return jsonData
    }
}
