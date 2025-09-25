//
//  LoadingIndicators.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct LoadingIndicators: View {
    let isLoading: Bool
    let isLoadingMore: Bool
    let hasMorePages: Bool
    let movies: [Movie]
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if isLoadingMore {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            if !hasMorePages && !movies.isEmpty {
                Text("No more movies to load")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
    }
}
