//
//  FavoriteButton.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

// MARK: - Main View
struct MovieListView: View {
    @State private var viewModel: MovieListViewModel
    @State private var searchText = ""
    
    init(repository: MovieRepositoryProtocol) {
        _viewModel = State(initialValue: MovieListViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText, onTextChange: handleSearchTextChange)
                MovieListContent(
                    viewModel: viewModel,
                    onAppear: { viewModel.loadInitialData() }
                )
            }
            .navigationTitle(Constants.Navigation.moviesTitle)
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") { viewModel.error = nil }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "")
            }
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
    
    private func handleSearchTextChange(_ newValue: String) {
        viewModel.searchQuery = newValue
        if newValue.isEmpty {
            viewModel.resetSearch()
        } else {
            viewModel.searchMovies()
        }
    }
}

// MARK: - Favorite Button
struct FavoriteButton: View {
    let isFavorite: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .gray)
                .imageScale(.large)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}


