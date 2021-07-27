//
//  PopularMoviesUseCase.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol PopularMoviesUseCase {
    func initialPageState() -> PageState

    typealias MoviesHandler = (Result<[Movie], ErrorType>) -> Void
    func execute(page: Int, callback: @escaping MoviesHandler)

    typealias ImageHandler = (Result<Data, ErrorType>) -> Void
    func execute(imageId: Movie.ImageId, callback: @escaping ImageHandler)
}

final class DefaultPopularMoviesUseCase: PopularMoviesUseCase {
    let popular: PopularMoviesRepository
    let image: MovieImageRepository

    init(
        popular: PopularMoviesRepository = DefaultPopularMoviesRepository(),
        image: MovieImageRepository = DefaultMovieImageRepository()
    ) {
        self.popular = popular
        self.image = image
    }

    func execute(page: Int, callback: @escaping MoviesHandler) {
        popular.movies(params: .init(page: page), callback: callback)
    }

    func initialPageState() -> PageState {
        popular.initialPageState()
    }

    func execute(imageId: Movie.ImageId, callback: @escaping ImageHandler) {
        image.image(id: imageId, callback: callback)
    }
}
