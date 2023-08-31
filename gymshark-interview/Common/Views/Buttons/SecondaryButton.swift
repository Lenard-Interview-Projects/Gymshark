//
//  SecondaryButton.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 31/08/2023.
//

import SwiftUI

struct SecondaryButton: View {
    var title: String
    var icon: String

    var action: () -> Void

    var body: some View {
        Button(action: { action() }) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.black)

                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(25)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Wishlist", icon: "heart", action: {})
    }
}
