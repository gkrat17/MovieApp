//
//  DefaultMovieImageRepository.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

final class DefaultMovieImageRepository: MovieImageRepository {
    private var requestBuilder: RequestBuilder { RequestBuilder(host: Bundle.main.resourceUrl, apiKey: nil) }
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService = DefaultDataTransferService()) {
        self.dataTransferService = dataTransferService
    }

    func image(id: Movie.ImageId, callback: @escaping ImageHandler) {
        let request = requestBuilder
            .set(method: .image(id: id))
            .build()

        dataTransferService.performTask(request: request, respondQueue: .main, callback: callback)
    }
}
