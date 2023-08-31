//
//  AttributedTextView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 31/08/2023.
//

import UIKit
import SwiftUI

struct TextHtml: UIViewRepresentable {
    private let htmlText: String

    init(_ text: String) {
        self.htmlText = text
    }

    func makeUIView(context: Context) -> UITextView {
        let uiTextView = UITextView()
        uiTextView.backgroundColor = .clear
        uiTextView.isEditable = false

        // Disable scrolling so the UITextView will set its `intrinsicContentSize` to match its text content.
        uiTextView.isScrollEnabled = false
        uiTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
        uiTextView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiTextView.setContentCompressionResistancePriority(.required, for: .vertical)
        uiTextView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return uiTextView
    }

    func updateUIView(_ uiTextView: UITextView, context: Context) {
        // Called the first time SwiftUI renders this UIViewRepresentable,
        // and whenever SwiftUI is notified about changes to its state.
        uiTextView.attributedText = NSAttributedString.html(withBody: htmlText)
    }
}
