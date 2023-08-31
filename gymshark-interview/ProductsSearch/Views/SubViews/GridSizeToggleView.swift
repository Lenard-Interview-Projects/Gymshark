//
//  GridSizeToggleView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI

struct GridSizeToggleView: View {
    @Namespace private var animation
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Image(systemName: !isSelected ? "square.grid.2x2.fill" : "square.grid.2x2")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 22)
                .padding(6)
                .padding(.horizontal, 16)
                .foregroundColor(Color.black)
                .background(alignment: .center) {
                    if !isSelected {
                        Color.white
                            .frame(maxWidth: .infinity, maxHeight: 35)
                            .background(Color.white)
                            .cornerRadius(16)
                            .matchedGeometryEffect(id: "Selection", in: animation)
                    }
                }

            Image(systemName: isSelected ? "square.fill" : "square")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 22)
                .padding(6)
                .padding(.horizontal, 16)
                .foregroundColor(Color.black)
                .background(alignment: .center) {
                    if isSelected {
                        Color.white
                            .frame(maxWidth: .infinity, maxHeight: 35)
                            .background(Color.white)
                            .cornerRadius(16)
                            .matchedGeometryEffect(id: "Selection", in: animation)
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(25)
        .onTapGesture {
            withAnimation(.spring()) {
                isSelected.toggle()
            }
        }
    }
}

struct GridSizeToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GridSizeToggleView(isSelected: .constant(false))
            GridSizeToggleView(isSelected: .constant(true))
        }
    }
}
