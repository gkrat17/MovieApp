//
//  NetworkService.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/26/21.
//

import Foundation

protocol NetworkService {
    func request(request: URLRequest, callback: @escaping (Result<Data?, ErrorType>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request(request: URLRequest, callback: @escaping (Result<Data?, ErrorType>) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            // http level error
            if let response = response as? HTTPURLResponse,
               !((200..<300) ~= response.statusCode) {
                return callback(.failure(.invalidStatusCode(httpCode: response.statusCode)))
            }
            // network level error
            if let error = error {
                if error._code == NSURLErrorNotConnectedToInternet {
                    return callback(.failure(.notConnectedToInternet))
                }
                return callback(.failure(.networkError(error: error)))
            }
            // success
            callback(.success(data))
        }.resume()
    }
}
