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
    func performTask(
        request: URLRequest,
        respondQueue: DispatchQueue,
        callback: @escaping (Result<Data, ErrorType>) -> Void
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
        performTaskWrapper(request, respondQueue, callback) { data in
            do {
                let decoder = JSONDecoder()
                let body = try decoder.decode(Response.Body.self, from: data)
                let entity = Response.entity(from: body)
                respondQueue.async { callback(.success(entity)) }
            } catch {
                respondQueue.async { callback(.failure(.jsonParsingError)) }
            }
        }
    }

    func performTask(
        request: URLRequest,
        respondQueue: DispatchQueue,
        callback: @escaping (Result<Data, ErrorType>) -> Void
    ) {
        performTaskWrapper(request, respondQueue, callback) { data in
            respondQueue.async { callback(.success(data)) }
        }
    }

    private func performTaskWrapper<SuccessType>(
        _ request: URLRequest,
        _ respondQueue: DispatchQueue,
        _ callback: @escaping (Result<SuccessType, ErrorType>) -> Void,
        _ onSuccessHandler: @escaping (Data) -> Void
    ) {
        networkService.request(request: request) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    onSuccessHandler(data)
                } else {
                    respondQueue.async { callback(.failure(.responseNotFound)) }
                }
            case .failure(let error):
                respondQueue.async { callback(.failure(error)) }
            }
        }
    }
}
