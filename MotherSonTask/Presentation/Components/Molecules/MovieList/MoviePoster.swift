//
//  MoviePoster.swift
//  MotherSonTask
//
//  Created by sunil biloniya on 25/09/25.
//

import SwiftUI

struct MoviePoster: View {
    let posterPath: String?
    
    var body: some View {
        if let posterPath = posterPath {
            CachedAsyncImage(url: URL(string: "\(Constants.API.imageBaseURL)\(posterPath)"))
                .aspectRatio(contentMode: .fill)
                .frame(height: Constants.UI.MovieCard.posterHeight)
                .clipped()
                .cornerRadius(Constants.UI.defaultCornerRadius)
        }
    }
}
