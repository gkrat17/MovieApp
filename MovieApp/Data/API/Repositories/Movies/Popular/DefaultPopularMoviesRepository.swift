//
//  DefaultPopularMoviesRepository.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

final class DefaultPopularMoviesRepository: PopularMoviesRepository {
    private var requestBuilder: RequestBuilder { RequestBuilder() }
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService = DefaultDataTransferService()) {
        self.dataTransferService = dataTransferService
    }

    func movies(params: PopularMoviesParams,
                callback: @escaping MoviesHandler) {
        let request = requestBuilder
            .set(method: .popular)
            .set(page: params.page)
            .build()

        dataTransferService.performTask(expecting: MovieDTO.self, request: request, respondQueue: .main, callback: callback)
    }
}
