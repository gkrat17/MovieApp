//
//  RequestBuilderTests.swift
//  MovieAppTests
//
//  Created by Giorgi Kratsashvili on 7/29/21.
//

import XCTest
@testable import MovieApp

class RequestBuilderTests: XCTestCase {
    private func create(host: String = "www.example.com", apiKey: String? = nil) -> RequestBuilder {
        RequestBuilder(host: host, apiKey: apiKey)
    }

    func testBuild() {
        // when
        let request = create()
            .build()

        // than
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com")
    }

    func testApiKey() {
        // when
        let request = create(apiKey: "API_KEY")
            .build()

        // than
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com?api_key=API_KEY")
    }

    func testSetMethod() {
        // when
        let request = create()
            .set(method: .popular)
            .build()

        // than
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com/3/tv/popular")
    }

    func testSetPage() {
        // when
        let request = create()
            .set(page: 1)
            .build()

        // than
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com?page=1")
    }

    func testSimultaneously() {
        // when
        let request = create(apiKey: "KEY")
            .set(method: .similar(id: 8))
            .set(page: 64)
            .build()

        // than
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com/3/tv/8/similar?api_key=KEY&page=64")
    }
}
