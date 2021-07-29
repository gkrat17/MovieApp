//
//  RequestBuilder.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

final class RequestBuilder {
    private var components: URLComponents

    init(
        host: String = Bundle.main.serviceUrl,
        apiKey: String? = Bundle.main.apiKey
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        if let apiKey = apiKey {
            components.queryItems = [.init(key: .apiKey, value: apiKey)]
        }
        self.components = components
    }

    func set(method: Method) -> Self {
        components.path = method.path
        return self
    }

    func set(page: Int) -> Self {
        if components.queryItems == nil {
            components.queryItems = []
        }
        components.queryItems?.append(.init(key: .page, value: "\(page)"))
        return self
    }

    func build() -> URLRequest {
        URLRequest(url: components.url!)
    }

    enum Method {
        case popular
        case similar(id: Int)
        case image(id: String)

        var path: String {
            switch self {
            case .popular:         return "/3/tv/popular"
            case .similar(let id): return "/3/tv/\(id)/similar"
            case .image(let id):   return "/t/p/w500\(id)"
            }
        }
    }

    fileprivate enum Key: String {
        case apiKey = "api_key"
        case page
    }
}

fileprivate extension URLQueryItem {
    init(key: RequestBuilder.Key, value: String?) {
        self.init(name: key.rawValue, value: value)
    }
}
