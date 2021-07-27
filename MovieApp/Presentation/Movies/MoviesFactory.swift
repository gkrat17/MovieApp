//
//  MoviesFactory.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MoviesFactory {
    func make() -> MoviesViewController
}

final class DefaultMoviesFactory: MoviesFactory {
    func make() -> MoviesViewController {
        let vc = MoviesViewController.getInstance()
        let navigator: MoviesNavigator = DefaultMoviesNavigator(vc: vc)
        let presenter: MoviesPresenter = DefaultMoviesPresenter(view: vc, navigator: navigator)
        vc.presenter = presenter
        return vc
    }
}
