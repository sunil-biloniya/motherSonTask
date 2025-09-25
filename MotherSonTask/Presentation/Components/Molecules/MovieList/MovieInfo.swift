//
//  MovieInfo.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct MovieInfo: View {
    let title: String
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let isFavorite: Bool
    let onFavoriteToggle: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                if let onFavoriteToggle = onFavoriteToggle {
                FavoriteButton(isFavorite: isFavorite, onToggle: onFavoriteToggle)
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            
            Text(overview)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(Constants.UI.MovieCard.overviewLineLimit)
            
            HStack {
                Text("\(Constants.Labels.release) \(releaseDate)")
                    .font(.caption)
                
                Spacer()
                
                Text("\(Constants.Labels.rating) \(String(format: "%.1f", voteAverage))")
                    .font(.caption)
            }
        }
    }
}
