//
//  RadioButton.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI

struct RadioButton<T: Equatable>: View {
    @Binding var selectedOption: T
    var option: T
    var title: String

    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack {
                Image(systemName: selectedOption == option ? "circle.circle.fill" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.black)
                Text(title)
                    .font(.body)
                    .fontWeight(.light)
                    .foregroundColor(Color.black)
            }
        }
    }
}


struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        RadioButton(selectedOption: .constant(""), option: "", title: "Option 1")
    }
}
