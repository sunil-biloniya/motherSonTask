//
//  SearchBar.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onTextChange: (String) -> Void
    
    var body: some View {
        HStack {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .medium))
            
            TextField(Constants.Navigation.searchPlaceholder, text: $text)
                .onChange(of: text) { _, newValue in
                    onTextChange(newValue)
                }
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                            .font(.system(size: 18))
                    }
                }
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}
