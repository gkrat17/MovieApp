//
//  PopularMoviesRepository.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol PopularMoviesRepository {
    func initialPageState() -> PageState

    typealias MoviesHandler = (Result<[Movie], ErrorType>) -> Void
    func movies(params: PopularMoviesParams, callback: @escaping MoviesHandler)
}

struct PopularMoviesParams {
    let page: Int
}
