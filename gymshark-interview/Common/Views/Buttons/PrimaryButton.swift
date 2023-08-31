//
//  PrimaryButton.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 31/08/2023.
//

import SwiftUI

struct PrimaryButton: View {
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
                    .foregroundColor(Color.white)

                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.blue)
        .cornerRadius(25)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Wishlist", icon: "heart", action: {})
    }
}
