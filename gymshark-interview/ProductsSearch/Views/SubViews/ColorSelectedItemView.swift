//
//  ColorSelectedItemView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI

struct ColorSelectedItemView: View {
    @Binding private var selection: [String]
    @State private var selected: Bool = false

    private var title: String
    private var color: Color

    init(selection: Binding<[String]>, title: String, color: Color) {
        self._selection = selection
        self.title = title
        self.color = color

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

    private func getBorderColor() -> Color {
        if color == Color.white { return Color.black }
        if color == Color.black { return Color.white }

        return Color.clear
    }

    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .frame(width: 55, height: 55)
                .overlay(alignment: .center) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 55)
                            .stroke(getBorderColor(), lineWidth: 1)

                        if selected {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.white)
                        }
                    }
                }

            Text(title)
                .font(.body)
                .foregroundColor(Color.black)
                .padding(.top, 12)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            selectedAction()
        }
    }
}

struct ColorSelectedItemView_Previews: PreviewProvider {
    @State static var selection: [String] = []

    static var previews: some View {
        ColorSelectedItemView(selection: $selection, title: "Red", color: Color.white)
    }
}
