//
//  Movie.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

struct Movie {
    let movieId: MovieId
    let imageId: ImageId?
    var image: Data?
    let name: String
    let overview: String
    let averageRating: Double

    typealias MovieId = Int
    typealias ImageId = String
}
