//
//  SimilarMoviesRepository.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol SimilarMoviesRepository {
    func initialPageState() -> PageState

    typealias MoviesHandler = (Result<[Movie], ErrorType>) -> Void
    func movies(params: SimilarMoviesParams, callback: @escaping MoviesHandler)
}

struct SimilarMoviesParams {
    let movieId: Movie.MovieId
    let page: Int
}
