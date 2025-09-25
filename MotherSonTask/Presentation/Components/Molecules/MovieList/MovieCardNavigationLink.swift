//
//  MovieCardNavigationLink.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct MovieCardNavigationLink: View {
    let movie: Movie
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(
            movie: movie,
            isFavorite: .init(
                get: { isFavorite },
                set: { _ in onFavoriteToggle() }
            ),
            onFavoriteToggle: onFavoriteToggle
        )) {
            MovieCard(movie: movie, isFavorite: isFavorite, onFavoriteToggle: onFavoriteToggle)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
