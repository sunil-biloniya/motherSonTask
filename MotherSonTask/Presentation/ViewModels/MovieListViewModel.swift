//
//  MovieListViewModel.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import Foundation
import Combine
import SwiftData

@Observable
class MovieListViewModel {
    private let repository: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchSubject = PassthroughSubject<String, Never>()
    
    // MARK: - State
    var movies: [Movie] = []
    var favorites: [Movie] = []
    var searchQuery = ""
    var isLoading = false
    var isLoadingMore = false
    var error: Error?
    
    var hasMorePages = true
    
    private var currentPage = 1
    private var hasLoadedInitialData = false
    
    // MARK: - Init
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
        setupSearchDebounce()
        loadFavorites()
    }
    
    // MARK: - Public Methods
    func loadInitialData() {
        guard !hasLoadedInitialData else { return }
        loadPopularMovies()
    }
    
    func searchMovies() {
        searchSubject.send(searchQuery)
    }
    
    func loadMoreMovies() {
        guard !isLoading && !isLoadingMore && hasMorePages else { return }
        currentPage += 1
        searchQuery.isEmpty ? loadPopularMovies() : performSearch(query: searchQuery, reset: false)
    }
    
    func toggleFavorite(_ movie: Movie) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        movies[index].isFavorite.toggle()
        
        repository.toggleFavorite(movie: movies[index])
        updateFavoritesLocally(with: movies[index])
    }
    
    func resetSearch() {
        searchQuery = ""
        currentPage = 1
        hasMorePages = true
        hasLoadedInitialData = false
        loadPopularMovies()
    }
    
    // MARK: - Private Methods
    private func setupSearchDebounce() {
        searchSubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query, reset: true)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String, reset: Bool) {
        guard !isLoading else { return }
        
        if reset {
            currentPage = 1
            movies.removeAll()
        }
        
        searchQuery = query
        query.isEmpty ? loadPopularMovies() : fetchMovies(using: repository.searchMovies(query: query, page: currentPage))
    }
    
    private func loadPopularMovies() {
        fetchMovies(using: repository.getPopularMovies(page: currentPage))
    }
    
    private func fetchMovies(using publisher: AnyPublisher<[Movie], Error>) {
        updateLoadingState()
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] newMovies in
                self?.handleMoviesResponse(newMovies)
            }
            .store(in: &cancellables)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        isLoading = false
        isLoadingMore = false
        
        if case .failure(let error) = completion {
            self.error = error
            self.hasMorePages = false
        }
    }
    
    private func handleMoviesResponse(_ newMovies: [Movie]) {
        if currentPage == 1 {
            movies = newMovies
        } else {
            movies.append(contentsOf: newMovies)
        }
        
        updateFavoriteStates()
        hasMorePages = !newMovies.isEmpty
        hasLoadedInitialData = true
    }
    
    private func updateLoadingState() {
        if currentPage == 1 {
            isLoading = true
        } else {
            isLoadingMore = true
        }
        error = nil
    }
    
    func loadFavorites() {
        favorites = repository.getFavorites()
        updateFavoriteStates()
    }
    
    private func updateFavoritesLocally(with movie: Movie) {
        if movie.isFavorite {
            favorites.append(movie)
        } else {
            favorites.removeAll { $0.id == movie.id }
        }
    }
    
    private func updateFavoriteStates() {
        for (index, movie) in movies.enumerated() {
            movies[index].isFavorite = favorites.contains { $0.id == movie.id }
        }
    }
}

