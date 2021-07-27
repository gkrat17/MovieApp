//
//  MoviesNavigator.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MoviesNavigator {}

final class DefaultMoviesNavigator: MoviesNavigator {
    private weak var vc: MoviesViewController?

    init(vc: MoviesViewController) {
        self.vc = vc
    }
}
