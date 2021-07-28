//
//  DetailsPresenter.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol DetailsView: AnyObject {}

protocol DetailsPresenter {
    func viewDidLoad()
}

struct DetailsParams {
    let movie: Movie
}

final class DefaultDetailsPresenter: DetailsPresenter {
    private let params: DetailsParams
    private weak var view: DetailsView?
    private let navigator: DetailsNavigator

    init(
        params: DetailsParams,
        view: DetailsView,
        navigator: DetailsNavigator
    ) {
        self.params = params
        self.view = view
        self.navigator = navigator
    }

    func viewDidLoad() {
        print("DetailsPresenter.viewDidLoad")
    }
}
