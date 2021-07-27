//
//  MovieDTO.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

struct MovieDTO: DataTransferResponse {
    struct Body: Codable {
        let results: [Entity]

        struct Entity: Codable {
            let backdropPath: String?
            let id: Int
            let name: String
            let overview: String
            let voteAverage: Double

            enum CodingKeys: String, CodingKey {
                case backdropPath = "backdrop_path"
                case id
                case name
                case overview
                case voteAverage = "vote_average"
            }
        }

        enum CodingKeys: String, CodingKey {
            case results
        }
    }

    typealias Entity = [Movie]

    static func entity(from body: Body) -> Entity {
        body.results.map {
            Movie(
                movieId: $0.id,
                imageId: $0.backdropPath,
                image: nil,
                name: $0.name,
                overview: $0.overview,
                averageRating: $0.voteAverage
            )
        }
    }
}
