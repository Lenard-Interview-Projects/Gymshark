//
//  NSAttributedString+Extension.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 31/08/2023.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func html(withBody body: String) -> NSAttributedString {
        var result: NSAttributedString?
        let dataBody = """
            <!doctype html>
            <html lang="en">
            <head>
                <meta charset="utf-8">
                <style type="text/css">
                    body {
                        font: -apple-system-body;
                        color: \(UIColor.black);
                    }
                </style>
            </head>
            <body>
                \(body)
            </body>
            </html>
            """.data(using: .utf8)

        guard let dataBody = dataBody else { return NSAttributedString(string: body) }

        do {
            result = try NSAttributedString(data: dataBody,
                                            options: [.documentType: NSAttributedString.DocumentType.html,
                                                      .characterEncoding: String.Encoding.utf8.rawValue],
                                            documentAttributes: nil)
        } catch {
            // Log the error into something like Firebase/Sentry
            print("error: ", error)
            return NSAttributedString(string: body)
        }

        return result ?? NSAttributedString(string: body)
    }
}
