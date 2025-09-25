//
//  MovieListContent.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct MovieListContent: View {
    let viewModel: MovieListViewModel
    let onAppear: () -> Void
    
    var body: some View {
        ZStack {
            if viewModel.movies.isEmpty && !viewModel.isLoading {
                EmptyStateView(
                    message: viewModel.searchQuery.isEmpty ? Constants.Labels.noMoviesFound : Constants.Labels.searchEmpty,
                    systemImage: viewModel.searchQuery.isEmpty ? "film" : "magnifyingglass"
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: Constants.UI.defaultSpacing) {
                        ForEach(viewModel.movies) { movie in
                            MovieCardNavigationLink(
                                movie: movie,
                                isFavorite: viewModel.favorites.contains(where: { $0.id == movie.id }),
                                onFavoriteToggle: { viewModel.toggleFavorite(movie) }
                            )
                            .onAppear {
                                if movie == viewModel.movies.last && !viewModel.isLoadingMore {
                                    viewModel.loadMoreMovies()
                                }
                            }
                        }
                        
                        LoadingIndicators(
                            isLoading: viewModel.isLoading,
                            isLoadingMore: viewModel.isLoadingMore,
                            hasMorePages: viewModel.hasMorePages,
                            movies: viewModel.movies
                        )
                    }
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: onAppear)
    }
}
