//
//  DefaultSimilarMoviesRepository.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

final class DefaultSimilarMoviesRepository: SimilarMoviesRepository {
    private var requestBuilder: RequestBuilder { RequestBuilder() }
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService = DefaultDataTransferService()) {
        self.dataTransferService = dataTransferService
    }

    func initialPageState() -> PageState {
        .init(initialPageIndex: 1, maxPageIndex: 1000, itemsPerPage: 20)
    }

    func movies(params: SimilarMoviesParams,
                callback: @escaping MoviesHandler) {
        let request = requestBuilder
            .set(method: .similar(id: params.movieId))
            .set(page: params.page)
            .build()

        dataTransferService.performTask(expecting: MovieDTO.self, request: request, respondQueue: .main, callback: callback)
    }
}
