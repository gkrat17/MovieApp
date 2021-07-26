//
//  DataTransferService.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/26/21.
//

import Foundation

protocol DataTransferService {
    func performTask<Response: DataTransferResponse>(
        expecting: Response.Type,
        request: URLRequest,
        respondQueue: DispatchQueue,
        callback: @escaping (Result<Response.Entity, ErrorType>) -> Void
    )
}

final class DefaultDataTransferService: DataTransferService {
    private let networkService: NetworkService

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func performTask<Response: DataTransferResponse>(
        expecting: Response.Type,
        request: URLRequest,
        respondQueue: DispatchQueue,
        callback: @escaping (Result<Response.Entity, ErrorType>) -> Void
    ) {
        networkService.request(request: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return respondQueue.async { callback(.failure(.responseNotFound)) }
                }
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(Response.Body.self, from: data)
                    let entity = Response.entity(from: body)
                    respondQueue.async { callback(.success(entity)) }
                } catch {
                    respondQueue.async { callback(.failure(.jsonParsingError)) }
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
