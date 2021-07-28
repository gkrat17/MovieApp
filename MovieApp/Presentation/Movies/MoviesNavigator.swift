//
//  MoviesNavigator.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol MoviesNavigator {
    func navigate2Details(with params: DetailsParams)
}

final class DefaultMoviesNavigator: MoviesNavigator {
    private weak var vc: MoviesViewController?
    private let detailsFactory: DetailsFactory

    init(
        vc: MoviesViewController,
        detailsFactory: DetailsFactory = DefaultDetailsFactory()
    ) {
        self.vc = vc
        self.detailsFactory = detailsFactory
    }

    func navigate2Details(with params: DetailsParams) {
        guard let parent = vc else { return }
        let vc = detailsFactory.make(with: params)
        parent.navigationController?.pushViewController(vc, animated: true)
    }
}
