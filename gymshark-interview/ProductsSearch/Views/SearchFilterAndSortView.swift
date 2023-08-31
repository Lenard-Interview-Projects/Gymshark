//
//  SearchFilterAndSortView.swift
//  gymshark-interview
//
//  Created by Lenard Pop on 29/08/2023.
//

import SwiftUI
import GymsharkServices

struct SearchFilterAndSortView: View {
    @Binding var sortBy: SearchSortBy
    @Binding var selectedSizes: [String]
    @Binding var selectedFits: [String]
    @Binding var selectedColours: [String]

    var body: some View {
        List {
            DisclosureGroup {
                    Group {
                        RadioButton(selectedOption: $sortBy, option: .PriceLowToHigh, title: "Price: Low to High")
                        RadioButton(selectedOption: $sortBy, option: .PriceHighToLow, title: "Price: High to Low")
                        RadioButton(selectedOption: $sortBy, option: .Relevancy, title: "Relevancy")
                        RadioButton(selectedOption: $sortBy, option: .Newest, title: "Newest")
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            } label: {
                HStack(spacing: 16) {
                    Text("SORT BY")
                        .font(.body)
                        .foregroundColor(Color.black)

                    Text(sortBy.toString())
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }

            DisclosureGroup {
                Group {
                    HStack {
                        BorderedSelectionItemView(selection: $selectedSizes, title: "XXS")
                        BorderedSelectionItemView(selection: $selectedSizes, title: "XS")
                        BorderedSelectionItemView(selection: $selectedSizes, title: "S")
                    }

                    HStack {
                        BorderedSelectionItemView(selection: $selectedSizes, title: "M")
                        BorderedSelectionItemView(selection: $selectedSizes, title: "L")
                        BorderedSelectionItemView(selection: $selectedSizes, title: "XL")
                    }

                    HStack {
                        BorderedSelectionItemView(selection: $selectedSizes, title: "XXL")
                        BorderedSelectionItemView(selection: $selectedSizes, title: "3XL")
                        BorderedSelectionItemView(selection: $selectedSizes, title: "1 Size")
                    }

                    HStack {
                        BorderedSelectionItemView(selection: $selectedSizes, title: "No Size")
                        VStack { }
                            .frame(maxWidth: .infinity)
                        VStack { }
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom, 8)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))

            } label: {
                HStack(spacing: 16) {
                    Text("SIZE")
                        .font(.body)
                        .foregroundColor(Color.black)

                    Text(selectedSizes.joined(separator: ","))
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }

            DisclosureGroup {
                Group {
                    HStack {
                        BorderedSelectionItemView(selection: $selectedFits, title: "Oversized")
                        BorderedSelectionItemView(selection: $selectedFits, title: "Regular")
                    }

                    HStack {
                        BorderedSelectionItemView(selection: $selectedFits, title: "Light")
                        BorderedSelectionItemView(selection: $selectedFits, title: "Medium")
                    }

                    HStack {
                        BorderedSelectionItemView(selection: $selectedFits, title: "Slim")
                        BorderedSelectionItemView(selection: $selectedFits, title: "High")
                    }
                }
                .padding(.bottom, 8)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                
            } label: {
                HStack(spacing: 16) {
                    Text("FIT")
                        .font(.body)
                        .foregroundColor(Color.black)

                    Text(selectedFits.joined(separator: ","))
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }

            DisclosureGroup {
                Group {
                    HStack {
                        ColorSelectedItemView(selection: $selectedColours, title: "Black", color: Color.black)
                        ColorSelectedItemView(selection: $selectedColours, title: "Blue", color: Color.blue)
                        ColorSelectedItemView(selection: $selectedColours, title: "Brown", color: Color.brown)
                    }

                    HStack {
                        ColorSelectedItemView(selection: $selectedColours, title: "Green", color: Color.green)
                        ColorSelectedItemView(selection: $selectedColours, title: "Gray", color: Color.gray)
                        ColorSelectedItemView(selection: $selectedColours, title: "Orange", color: Color.orange)
                    }

                    HStack {
                        ColorSelectedItemView(selection: $selectedColours, title: "Pink", color: Color.pink)
                        ColorSelectedItemView(selection: $selectedColours, title: "Purple", color: Color.purple)
                        ColorSelectedItemView(selection: $selectedColours, title: "Red", color: Color.red)
                    }

                    HStack {
                        ColorSelectedItemView(selection: $selectedColours, title: "White", color: Color.white)
                        ColorSelectedItemView(selection: $selectedColours, title: "Yellow", color: Color.yellow)
                        VStack { }
                            .frame(maxWidth: .infinity)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 16))
            } label: {
                HStack(spacing: 16) {
                    Text("COLOUR")
                        .font(.body)
                        .foregroundColor(Color.black)

                    Text(selectedColours.joined(separator: ","))
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Collapsible List")
    }
}

struct SearchFilterAndSortView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterAndSortView(sortBy: .constant(.Newest), selectedSizes: .constant([]), selectedFits: .constant([]), selectedColours: .constant([]))
    }
}
