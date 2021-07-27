//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MoviesView: AnyObject {}

protocol MoviesPresenter {
    func viewDidLoad()
}

final class DefaultMoviesPresenter: MoviesPresenter {
    private weak var view: MoviesView?
    private let navigator: MoviesNavigator

    init(
        view: MoviesView,
        navigator: MoviesNavigator
    ) {
        self.view = view
        self.navigator = navigator
    }

    func viewDidLoad() {
        print("MoviesPresenter.viewDidLoad")
    }
}
