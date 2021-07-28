//
//  SimilarMoviesUseCase.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/28/21.
//

import Foundation

protocol SimilarMoviesUseCase {
    func initialPageState() -> PageState

    typealias MoviesHandler = (Result<[Movie], ErrorType>) -> Void
    func execute(movieId: Movie.MovieId, page: Int, callback: @escaping MoviesHandler)

    typealias ImageHandler = (Result<Data, ErrorType>) -> Void
    func execute(imageId: Movie.ImageId, callback: @escaping ImageHandler)
}

final class DefaultSimilarMoviesUseCase: SimilarMoviesUseCase {
    let similar: SimilarMoviesRepository
    let image: MovieImageRepository

    init(
        similar: SimilarMoviesRepository = DefaultSimilarMoviesRepository(),
        image: MovieImageRepository = DefaultMovieImageRepository()
    ) {
        self.similar = similar
        self.image = image
    }

    func initialPageState() -> PageState {
        similar.initialPageState()
    }

    func execute(movieId: Movie.MovieId, page: Int, callback: @escaping MoviesHandler) {
        similar.movies(params: .init(movieId: movieId, page: page), callback: callback)
    }

    func execute(imageId: Movie.ImageId, callback: @escaping ImageHandler) {
        image.image(id: imageId, callback: callback)
    }
}
