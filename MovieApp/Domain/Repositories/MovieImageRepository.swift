//
//  MovieImageRepository.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MovieImageRepository {
    typealias ImageHandler = (Result<Data, ErrorType>) -> Void
    func image(id: Movie.ImageId, callback: @escaping ImageHandler)
}
