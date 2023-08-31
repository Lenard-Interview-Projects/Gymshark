//
//  BorderedSelectionItemView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI

struct BorderedSelectionItemView: View {
    @Binding private var selection: [String]
    @State private var selected: Bool = false

    private var title: String
    private var isDisabled: Bool

    init(selection: Binding<[String]>, title: String, isDisabled: Bool = false) {
        self._selection = selection
        self.title = title
        self.isDisabled = isDisabled

        _selected = State(wrappedValue: self.selection.contains { $0 == title })
    }

    private func selectedAction() {
        if !title.isEmpty {
            withAnimation(.easeIn) {
                selected.toggle()
            }

            if selected { selection.append(title) }
            else { selection.removeAll { $0 == title } }
        }
    }

    var body: some View {
        Text(title)
            .font(.body)
            .fontWeight(.light)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .background(isDisabled ? Color.gray.opacity(0.2) : selected ? Color.black : Color.white)
            .foregroundColor(isDisabled ? Color.gray : selected ? Color.white : Color.black)
            .border(isDisabled ? Color.gray.opacity(0.5) : Color.gray, width: 1)
            .onTapGesture {
                if !isDisabled {
                    selectedAction()
                }
            }
    }
}

struct BorderedSelectionItemView_Previews: PreviewProvider {
    @State static var selection: [String] = []

    static var previews: some View {
        VStack {
            BorderedSelectionItemView(selection: $selection, title: "XS")
            BorderedSelectionItemView(selection: $selection, title: "XS", isDisabled: true)
        }
    }
}
