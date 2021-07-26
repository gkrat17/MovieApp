//
//  ErrorType.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/26/21.
//

import Foundation

enum ErrorType {
    case invalidStatusCode(httpCode: Int)
    case notConnectedToInternet
    case networkError(error: Error)
    case responseNotFound
    case jsonParsingError
    case `default`
    case error(from: Error)

    var errorMessage: String {
        switch self {
        case .invalidStatusCode(let httpCode): return "Invalid status code responded: \(httpCode)"
        case .notConnectedToInternet:          return "Not connected to internet"
        case .networkError(let error):         return "Network error occured: \(error.localizedDescription)"
        case .responseNotFound:                return "Response not found"
        case .jsonParsingError:                return "JSON parsing error"
        case .default:                         return "Something went wrong"
        case .error(let error):                return error.localizedDescription
        }
    }
}

extension ErrorType: LocalizedError {
    var errorDescription: String? { errorMessage }
}
