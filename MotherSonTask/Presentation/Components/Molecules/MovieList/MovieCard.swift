//
//  MovieCard.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    let isFavorite: Bool
    let onFavoriteToggle: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.UI.defaultSpacing) {
            MoviePoster(posterPath: movie.posterPath)
            MovieInfo(
                title: movie.title,
                overview: movie.overview,
                releaseDate: movie.releaseDate,
                voteAverage: movie.voteAverage,
                isFavorite: isFavorite,
                onFavoriteToggle: onFavoriteToggle
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(Constants.UI.defaultCornerRadius)
        .shadow(radius: Constants.UI.defaultShadowRadius)
    }
}
